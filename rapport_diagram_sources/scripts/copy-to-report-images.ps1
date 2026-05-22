# Copy output/png/*.png into rapport_stage_extracted_images/images/
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$Src = Join-Path $Root "output\png"
$Dst = Join-Path (Split-Path -Parent $Root) "rapport_stage_extracted_images\images"

if (-not (Test-Path $Src)) {
    Write-Error "Run .\scripts\export-all.ps1 first (missing $Src)"
}

Get-ChildItem $Src -Filter "*.png" | ForEach-Object {
    Copy-Item -Force $_.FullName (Join-Path $Dst $_.Name)
    Write-Host "Copied $($_.Name)"
}
