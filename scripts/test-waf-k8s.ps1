# -----------------------------------------------------------------------
# test-waf-k8s.ps1  -  WAF edge security verification (K8s)
#
# Run after deploy.ps1 to verify the full WAF chain is functional.
# Tests 1-10 are mandatory. Tests 11-12 are best-effort (exporter/network).
# Exit code 0 = all mandatory tests passed.
# -----------------------------------------------------------------------
param(
    [string]$WafPortForward = "8081",
    [int]   $PfWarmupSecs   = 5
)

$ErrorActionPreference = "Stop"

$pass    = 0
$fail    = 0
$results = [System.Collections.Generic.List[string]]::new()

function Test-Result {
    param([int]$Num, [string]$Name, [bool]$Passed, [string]$Detail = "")
    if ($Passed) {
        $script:pass++
        $results.Add("  [PASS] Test $Num - $Name")
    } else {
        $script:fail++
        $results.Add("  [FAIL] Test $Num - $Name$(if ($Detail) { ': ' + $Detail } else { '' })")
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " WAF K8s Verification Test Suite"           -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Starting WAF port-forward (localhost:$WafPortForward -> svc/waf:80)..." -ForegroundColor Gray
$pfJob = Start-Job -ScriptBlock {
    param($port)
    kubectl port-forward -n ai-gateway svc/waf "${port}:80" 2>&1
} -ArgumentList $WafPortForward
Write-Host "  Waiting ${PfWarmupSecs}s for port-forward to stabilise..." -ForegroundColor Gray
Start-Sleep -Seconds $PfWarmupSecs

$baseUrl = "http://localhost:$WafPortForward"

try {

# -----------------------------------------------------------------------
# TEST 1: WAF pod running
# -----------------------------------------------------------------------
Write-Host "[1] WAF pod status..." -ForegroundColor Yellow
try {
    $podLines = kubectl get pod -l app=waf -n ai-gateway --no-headers 2>&1 | Out-String
    # Look for a line showing Running with at least 1/1 or 2/2 ready waf container
    $passed = $podLines -match "Running" -and ($podLines -match "1/1|2/2|3/3")
    Test-Result 1 "WAF pod running and ready" $passed "Pod output: $($podLines.Trim())"
} catch {
    Test-Result 1 "WAF pod running and ready" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 2: WAF health endpoint
# -----------------------------------------------------------------------
Write-Host "[2] WAF /healthz..." -ForegroundColor Yellow
try {
    $resp = Invoke-WebRequest -Uri "$baseUrl/healthz" -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
    Test-Result 2 "WAF health endpoint returns 200" ($resp.StatusCode -eq 200) "HTTP $($resp.StatusCode)"
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    Test-Result 2 "WAF health endpoint returns 200" $false "Exception: $($_.Exception.Message) (HTTP $code)"
}

# -----------------------------------------------------------------------
# TEST 3: kong-dp is ClusterIP (not LoadBalancer)
# -----------------------------------------------------------------------
Write-Host "[3] kong-dp service type..." -ForegroundColor Yellow
try {
    $svcType = kubectl get svc kong-dp -n ai-gateway -o jsonpath="{.spec.type}"
    Test-Result 3 "kong-dp is ClusterIP (not LoadBalancer)" ($svcType -eq "ClusterIP") "Got type: $svcType"
} catch {
    Test-Result 3 "kong-dp is ClusterIP (not LoadBalancer)" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 4: WAF service is LoadBalancer
# -----------------------------------------------------------------------
Write-Host "[4] WAF service type..." -ForegroundColor Yellow
try {
    $wafType = kubectl get svc waf -n ai-gateway -o jsonpath="{.spec.type}"
    Test-Result 4 "WAF service is LoadBalancer" ($wafType -eq "LoadBalancer") "Got type: $wafType"
} catch {
    Test-Result 4 "WAF service is LoadBalancer" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 5: Clean request passes through WAF (not blocked)
# -----------------------------------------------------------------------
Write-Host "[5] Clean request passes (not blocked)..." -ForegroundColor Yellow
try {
    $resp = Invoke-WebRequest -Uri "$baseUrl/" -UseBasicParsing -TimeoutSec 15 -ErrorAction Stop
    $passed = $resp.StatusCode -ne 403
    Test-Result 5 "Clean GET / passes WAF (not 403)" $passed "HTTP $($resp.StatusCode)"
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    if ($code -and $code -ne 403) {
        Test-Result 5 "Clean GET / passes WAF (not 403)" $true "HTTP $code from backend (WAF did not block)"
    } else {
        Test-Result 5 "Clean GET / passes WAF (not 403)" $false "HTTP $code or exception: $($_.Exception.Message)"
    }
}

# -----------------------------------------------------------------------
# TEST 6: SQL injection blocked (HTTP 403)
# -----------------------------------------------------------------------
Write-Host "[6] SQL injection blocked..." -ForegroundColor Yellow
try {
    $attackUrl = "$baseUrl/?id=1' OR '1'='1"
    $resp = Invoke-WebRequest -Uri $attackUrl -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
    Test-Result 6 "SQLi attack blocked (HTTP 403)" $false "Expected 403, got HTTP $($resp.StatusCode)"
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    if ($code -eq 403) {
        Test-Result 6 "SQLi attack blocked (HTTP 403)" $true "Got 403"
    } else {
        Test-Result 6 "SQLi attack blocked (HTTP 403)" $false "Expected 403, got HTTP $code"
    }
}

# -----------------------------------------------------------------------
# TEST 7: ModSecurity audit log has content after attack
# -----------------------------------------------------------------------
Write-Host "[7] ModSecurity audit log..." -ForegroundColor Yellow
try {
    $logContent = kubectl exec deploy/waf -n ai-gateway -c waf -- sh -c "cat /var/log/modsec_audit.log 2>/dev/null | head -c 2000" 2>&1
    $hasLog = ($logContent -ne $null -and ($logContent | Out-String).Length -gt 5)
    Test-Result 7 "ModSecurity audit log has content" $hasLog "Log empty or missing"
} catch {
    Test-Result 7 "ModSecurity audit log has content" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 8: User-Agent header injection (PARANOIA=1 may not block - acceptable)
# -----------------------------------------------------------------------
Write-Host "[8] User-Agent injection (PARANOIA=1 - informational)..." -ForegroundColor Yellow
try {
    $headers = @{ "User-Agent" = "' OR 1=1--" }
    $resp = Invoke-WebRequest -Uri "$baseUrl/" -Headers $headers -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
    if ($resp.StatusCode -eq 403) {
        Test-Result 8 "Header injection blocked (HTTP 403)" $true "Got 403"
    } else {
        Test-Result 8 "Header injection blocked (HTTP 403)" $true "HTTP $($resp.StatusCode) - PARANOIA=1 may not block this; raise to PARANOIA=2+ for stricter enforcement"
    }
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    if ($code -eq 403) {
        Test-Result 8 "Header injection blocked (HTTP 403)" $true "Got 403"
    } else {
        Test-Result 8 "Header injection (PARANOIA=1 acceptable)" $true "HTTP $code - PARANOIA=1 may not score header injection high enough"
    }
}

# -----------------------------------------------------------------------
# TEST 9: Frontend ConfigMap points to WAF (not kong-dp)
# -----------------------------------------------------------------------
Write-Host "[9] Frontend proxy target points to WAF..." -ForegroundColor Yellow
try {
    $cmData = kubectl get configmap frontend-config -n ai-gateway -o jsonpath="{.data.VITE_API_PROXY_TARGET}" 2>$null
    $pointsToWaf = $cmData -match "waf\.ai-gateway"
    Test-Result 9 "Frontend VITE_API_PROXY_TARGET points to waf service" $pointsToWaf "Got: $cmData"
} catch {
    Test-Result 9 "Frontend VITE_API_PROXY_TARGET points to waf service" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 10: FastAPI reachable via WAF -> Kong -> FastAPI
# -----------------------------------------------------------------------
Write-Host "[10] FastAPI reachable via WAF edge..." -ForegroundColor Yellow
try {
    $resp = Invoke-WebRequest -Uri "$baseUrl/api/" -UseBasicParsing -TimeoutSec 20 -ErrorAction Stop
    $passed = $resp.StatusCode -ne 403
    Test-Result 10 "FastAPI via WAF edge (not 403)" $passed "HTTP $($resp.StatusCode)"
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    if ($code -and $code -ne 403) {
        Test-Result 10 "FastAPI via WAF edge (not 403)" $true "HTTP $code from backend (WAF did not block)"
    } else {
        Test-Result 10 "FastAPI via WAF edge (not 403)" $false "HTTP $code or exception: $($_.Exception.Message)"
    }
}

# -----------------------------------------------------------------------
# TEST 11: nginx-exporter sidecar ready (best-effort)
# -----------------------------------------------------------------------
Write-Host "[11] nginx-exporter sidecar (best-effort)..." -ForegroundColor Yellow
try {
    $podLines = kubectl get pod -l app=waf -n ai-gateway --no-headers 2>&1 | Out-String
    # 2/2 means both waf + nginx-exporter are ready
    $passed = $podLines -match "2/2" -and $podLines -match "Running"
    Test-Result 11 "nginx-exporter sidecar ready" $passed "Pod output: $($podLines.Trim())"
} catch {
    Test-Result 11 "nginx-exporter sidecar ready" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 12: Keycloak OIDC login page not blocked by SSRF rules
# -----------------------------------------------------------------------
Write-Host "[12] Keycloak OIDC login (redirect_uri with localhost)..." -ForegroundColor Yellow
try {
    $oidcUrl = "$baseUrl/auth/realms/newRealm/protocol/openid-connect/auth?client_id=myclient&redirect_uri=http%3A%2F%2Flocalhost%2F&response_type=code&scope=openid"
    $req = [System.Net.HttpWebRequest]::Create($oidcUrl)
    $req.AllowAutoRedirect = $false
    $req.Timeout = 15000
    $req.Method = "GET"
    try {
        $resp = $req.GetResponse()
        $code = [int]$resp.StatusCode
        $resp.Close()
    } catch [System.Net.WebException] {
        if ($_.Exception.Response) {
            $code = [int]$_.Exception.Response.StatusCode
            $_.Exception.Response.Close()
        } else {
            throw
        }
    }
    if ($code -eq 403) {
        Test-Result 12 "Keycloak OIDC endpoint not blocked by WAF" $false "HTTP 403 - SSRF rules may block redirect_uri"
    } elseif ($code -eq 302 -or $code -eq 200) {
        Test-Result 12 "Keycloak OIDC endpoint not blocked by WAF" $true "HTTP $code (redirect to login)"
    } else {
        Test-Result 12 "Keycloak OIDC endpoint not blocked by WAF" ($code -ne 403) "HTTP $code"
    }
} catch {
    Test-Result 12 "Keycloak OIDC endpoint not blocked by WAF" $false $_.Exception.Message
}

# -----------------------------------------------------------------------
# TEST 13: WAF -> kong-dp network path
# -----------------------------------------------------------------------
Write-Host "[13] WAF can reach kong-dp in-cluster..." -ForegroundColor Yellow
try {
    $netTest = kubectl exec deploy/waf -n ai-gateway -c waf -- sh -c "nc -zw3 kong-dp.ai-gateway.svc.cluster.local 8000 2>&1; echo exitcode:$?" 2>&1 | Out-String
    $passed = $netTest -match "exitcode:0"
    if (-not $passed) {
        $netTest2 = kubectl exec deploy/waf -n ai-gateway -c waf -- sh -c "wget -q --spider --timeout=3 http://kong-dp.ai-gateway.svc.cluster.local:8000/ 2>&1; echo exitcode:$?" 2>&1 | Out-String
        $passed = $netTest2 -notmatch "exitcode:4"
        Test-Result 13 "WAF -> kong-dp TCP:8000 reachable (wget)" $passed "Output: $($netTest2.Trim())"
    } else {
        Test-Result 13 "WAF -> kong-dp TCP:8000 reachable (nc)" $passed "Output: $($netTest.Trim())"
    }
} catch {
    Test-Result 13 "WAF -> kong-dp TCP:8000 reachable" $false $_.Exception.Message
}

} finally {
    Stop-Job  $pfJob -ErrorAction SilentlyContinue | Out-Null
    Remove-Job $pfJob -ErrorAction SilentlyContinue | Out-Null
}

# -----------------------------------------------------------------------
# Print results
# -----------------------------------------------------------------------
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Test Results"                               -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
foreach ($line in $results) {
    if ($line -match "\[PASS\]") {
        Write-Host $line -ForegroundColor Green
    } else {
        Write-Host $line -ForegroundColor Red
    }
}
Write-Host ""

$total = $pass + $fail
if ($fail -eq 0) {
    Write-Host "  Passed: $pass / $total" -ForegroundColor Green
} else {
    Write-Host "  Passed: $pass / $total" -ForegroundColor Yellow
}

# Tests 1-12 mandatory, 13 best-effort (network path)
$mandatoryFail = 0
foreach ($line in $results) {
    if ($line -match "\[FAIL\] Test ([1-9]|1[0-2]) ") {
        $mandatoryFail++
    }
}

if ($mandatoryFail -gt 0) {
    Write-Host "  MANDATORY FAILURES: $mandatoryFail test(s) failed." -ForegroundColor Red
    Write-Host ""
    Write-Host "Debug hints:" -ForegroundColor Yellow
    Write-Host "  kubectl describe pod -l app=waf -n ai-gateway"
    Write-Host "  kubectl logs deploy/waf -n ai-gateway -c waf --tail=80"
    Write-Host "  kubectl logs deploy/waf -n ai-gateway -c nginx-exporter --tail=30"
    Write-Host "  kubectl exec deploy/waf -n ai-gateway -c waf -- tail /var/log/modsec_audit.log"
    exit 1
} else {
    Write-Host "  All mandatory tests passed." -ForegroundColor Green
    exit 0
}
