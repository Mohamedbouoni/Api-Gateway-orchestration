# Export all Mermaid + PlantUML sources to output/png/
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$MmdDir = Join-Path $Root "mermaid"
$PumlDir = Join-Path $Root "plantuml"
$OutDir = Join-Path $Root "output\png"
$Width = 2400

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$mermaidMap = @{
    "sprint1_sequence.mmd" = "sprint1_sequence.png"
    "sprint3_sequence.mmd" = "sprint3_sequence.png"
    "sprint4_sequence.mmd" = "sprint4_sequence.png"
    "end_to_end_orchestration.mmd" = "end_to_end_orchestration.png"
    "Sequence_diagramm.mmd" = "Sequence_diagramm.png"
    "endUser_diagramm.mmd" = "endUser_diagramm.png"
    "admin_sequence_diagramm.mmd" = "admin_sequence_diagramm.png"
    "plugin_pipeline_styled.mmd" = "plugin_pipeline_styled.png"
    "cicd_pipeline.mmd" = "cicd_pipeline.png"
    "k8s_architecture_styled.mmd" = "k8s_architecture_styled.png"
    "architecture_platform.mmd" = "architecture_platform.png"
    "digramme_generale.mmd" = "digramme_generale.png"
    "sprint_velocity.mmd" = "sprint_velocity.png"
    "centrelized.mmd" = "centrelized.png"
    "problem_vs_solution.mmd" = "problem_vs_solution.png"
}

Write-Host "==> Mermaid ($($mermaidMap.Count) files)" -ForegroundColor Cyan
foreach ($entry in $mermaidMap.GetEnumerator()) {
    $in = Join-Path $MmdDir $entry.Key
    $out = Join-Path $OutDir $entry.Value
    if (-not (Test-Path $in)) { Write-Warning "Missing $in"; continue }
    Write-Host "  $($entry.Key) -> $($entry.Value)"
    npx --yes @mermaid-js/mermaid-cli -i $in -o $out -w $Width -b white
}

$plantumlMap = @{
    "sprint2_class.puml" = "sprint2_class.png"
    "ldm_sprint2.puml" = "ldm_sprint2.png"
}

function Export-PlantUmlFile {
    param([string]$Src, [string]$TargetName)
    $generated = Join-Path $OutDir ([System.IO.Path]::GetFileNameWithoutExtension($Src) + ".png")
    $target = Join-Path $OutDir $TargetName
    if ((Test-Path $generated) -and ($generated -ne $target)) {
        Move-Item -Force $generated $target
    }
}

$plantumlCmd = Get-Command plantuml -ErrorAction SilentlyContinue
$plantumlJar = Join-Path $Root "tools\plantuml.jar"
if (-not (Test-Path $plantumlJar)) {
    $toolsDir = Join-Path $Root "tools"
    New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null
    Write-Host "Downloading plantuml.jar (one-time)..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://github.com/plantuml/plantuml/releases/download/v1.2024.8/plantuml-1.2024.8.jar" -OutFile $plantumlJar
}

Write-Host "==> PlantUML" -ForegroundColor Cyan
foreach ($entry in $plantumlMap.GetEnumerator()) {
    $src = Join-Path $PumlDir $entry.Key
    if (-not (Test-Path $src)) { Write-Warning "Missing $src"; continue }
    Write-Host "  $($entry.Key) -> $($entry.Value)"
    $outAbs = (Resolve-Path $OutDir).Path
    if ($plantumlCmd) {
        & plantuml -tpng -o $outAbs $src
    } else {
        java -jar $plantumlJar -tpng -o $outAbs $src
    }
    Export-PlantUmlFile -Src $entry.Key -TargetName $entry.Value
}

Write-Host "Done: $OutDir" -ForegroundColor Green
