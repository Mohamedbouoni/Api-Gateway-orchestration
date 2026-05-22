Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🚀 Starting Enterprise AI Gateway UI Links" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Opening background terminals for Port Forwarding..." -ForegroundColor Yellow

# Forward WAF (public edge — same traffic path as docker-compose WAF on :8081)
# Note: WAF LoadBalancer also binds :80 directly on Docker Desktop (http://localhost).
# Port 8081 is convenient for test scripts when :80 is already bound.
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'WAF Edge (8081)'; kubectl port-forward -n ai-gateway svc/waf 8081:80"

# Forward Frontend
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'Frontend (5173)'; kubectl port-forward -n ai-gateway svc/frontend 5173:80"

# Forward Kong Manager (Admin UI)
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'Kong Manager (8002)'; kubectl port-forward -n ai-gateway svc/kong-cp 8002:8002"
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'Kong Manager (8001)'; kubectl port-forward -n ai-gateway svc/kong-cp 8001:8001"

# Forward Grafana
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'Grafana (3001)'; kubectl port-forward -n ai-monitoring svc/grafana 3001:3000"

# Forward keycloak port:
Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoExit -Command title 'keycloak 8080'; kubectl port-forward -n ai-application svc/keycloak 8080:8080"

Start-Sleep -Seconds 3 

Write-Host "All ports forwarded successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "You can now access your project at the following URLs:" -ForegroundColor White
Write-Host "------------------------------------------------------"
Write-Host "  Public Edge (WAF LB):  http://localhost         (LoadBalancer on :80 - all traffic inspected by ModSecurity)" -ForegroundColor Cyan
Write-Host "  WAF Port-Forward:      http://localhost:8081    (port-forward for direct edge testing and test scripts)" -ForegroundColor Cyan
Write-Host "  Frontend UI:           http://localhost:5173    (via port 80)" -ForegroundColor Cyan
Write-Host "  Keycloak Login:        http://localhost/auth || http://localhost:8080" -ForegroundColor Cyan
Write-Host "  Kong Manager:          http://localhost:8002" -ForegroundColor Cyan
Write-Host "  Kong Admin API:        http://localhost:8001" -ForegroundColor Cyan
Write-Host "  Grafana:               http://localhost:3001    (Admin Portal embeds)" -ForegroundColor Cyan
Write-Host ""
Write-Host "WAF audit log:  kubectl exec -n ai-gateway deploy/waf -c waf -- tail -f /var/log/modsec_audit.log" -ForegroundColor Gray
Write-Host "Optional admin direct access: kubectl port-forward -n ai-application svc/keycloak 8080:8080" -ForegroundColor Gray
Write-Host "(Note: minimized PowerShell windows keep port-forwards alive. Close them when you are done)." -ForegroundColor Gray
