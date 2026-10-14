# sign-local.ps1 — Sigstore sign a release ZIP using your GitHub identity
#
# Usage:
#   .\scripts\sign-local.ps1 path\to\BrowserRecon-Portable-v1.0.0-windows.zip
#
# Result:
#   Creates path\to\BrowserRecon-Portable-v1.0.0-windows.zip.sigstore.json
#   Records a transparency-log entry at https://search.sigstore.dev
#
# Prerequisites:
#   * Python 3.10+ with `pip install sigstore`
#   * A browser (opens for GitHub OIDC sign-in)

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Zip
)

if (-not (Test-Path $Zip)) {
    Write-Host "ERROR: file not found: $Zip" -ForegroundColor Red
    exit 1
}

# Check sigstore is installed
python -m sigstore --version > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "sigstore-python is not installed. Install with:" -ForegroundColor Yellow
    Write-Host "  python -m pip install sigstore" -ForegroundColor Yellow
    $ans = Read-Host "Install now? (y/N)"
    if ($ans -eq "y" -or $ans -eq "Y") {
        python -m pip install sigstore
    } else {
        exit 1
    }
}

$bundle = "$Zip.sigstore.json"
Write-Host "Signing: $Zip" -ForegroundColor Cyan
Write-Host "Bundle:  $bundle" -ForegroundColor Cyan
Write-Host ""
Write-Host "A browser window will open. Sign in with your GitHub account." -ForegroundColor Yellow
Write-Host ""

python -m sigstore sign --bundle $bundle $Zip
$code = $LASTEXITCODE

if ($code -eq 0 -and (Test-Path $bundle)) {
    Write-Host ""
    Write-Host "SIGNED OK" -ForegroundColor Green
    Write-Host "Upload BOTH files to the GitHub Release:"
    Write-Host "  - $Zip"
    Write-Host "  - $bundle"
    Write-Host ""
    Write-Host "Users can verify with:  .\scripts\verify.ps1 $Zip"
} else {
    Write-Host ""
    Write-Host "SIGNING FAILED (exit $code)" -ForegroundColor Red
    exit 1
}
