# verify.ps1 — Verify a downloaded release ZIP using its Sigstore bundle
#
# Usage:
#   .\scripts\verify.ps1 path\to\BrowserRecon-Portable-v1.0.0-windows.zip
#
# What this proves:
#   The ZIP was signed by Mathan Subbiah's GitHub account (PrototypePrime)
#   via the public Sigstore transparency log (Rekor).
#
# What this does NOT prove:
#   It does NOT clear Windows SmartScreen warnings. SmartScreen needs an
#   Authenticode signature from a commercial Certificate Authority. The
#   binaries shipped here use Sigstore for *provenance* (who built it),
#   not Authenticode (Microsoft's commercial signing chain).
#
# Prerequisites:
#   * Python 3.10+ with `pip install sigstore`

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Zip
)

if (-not (Test-Path $Zip)) {
    Write-Host "ERROR: file not found: $Zip" -ForegroundColor Red
    exit 1
}

$bundle = "$Zip.sigstore.json"
if (-not (Test-Path $bundle)) {
    Write-Host "ERROR: signature bundle not found at: $bundle" -ForegroundColor Red
    Write-Host "  Download the .sigstore.json file from the same Release page." -ForegroundColor Yellow
    exit 1
}

python -m sigstore --version > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "sigstore-python is not installed. Install with:" -ForegroundColor Yellow
    Write-Host "  python -m pip install sigstore" -ForegroundColor Yellow
    exit 1
}

Write-Host "Verifying: $Zip" -ForegroundColor Cyan
Write-Host "Bundle:    $bundle" -ForegroundColor Cyan
Write-Host ""

# Expect the signature was minted by Mathan's GitHub identity
$ExpectedIdentity = "https://github.com/PrototypePrime"
$ExpectedIssuer   = "https://github.com/login/oauth"

python -m sigstore verify identity `
    --bundle $bundle `
    --cert-identity $ExpectedIdentity `
    --cert-oidc-issuer $ExpectedIssuer `
    $Zip

$code = $LASTEXITCODE
Write-Host ""
if ($code -eq 0) {
    Write-Host "VERIFIED OK" -ForegroundColor Green
    Write-Host "  Built by:  $ExpectedIdentity"
    Write-Host "  Issuer:    $ExpectedIssuer"
    Write-Host "  See full provenance at: https://search.sigstore.dev"
} else {
    Write-Host "VERIFICATION FAILED (exit $code)" -ForegroundColor Red
    Write-Host "  Do NOT trust this download." -ForegroundColor Red
    exit 1
}
