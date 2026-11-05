# Pubblica una versione di MakerForge su GitHub (repository pubblico solo-installer).
# Uso: powershell -ExecutionPolicy Bypass -File publish-release.ps1 -Version 0.4.0
# Carica i file per gli aggiornamenti automatici (exe + blockmap + latest.yml / lite.yml)
# e due copie con nome fisso, cosi' il link .../releases/latest/download/MakerForge-Setup-Windows.exe
# punta sempre all'ultima versione.
param([Parameter(Mandatory = $true)][string]$Version)
$ErrorActionPreference = 'Stop'
$gh = 'C:\Program Files\GitHub CLI\gh.exe'
$here = $PSScriptRoot
$dist = 'C:\Users\spakk\MakerForge\dist'
$notes = Join-Path $here "notes\v$Version.md"

$update = @(
  "MakerForge-Setup-$Version.exe", "MakerForge-Setup-$Version.exe.blockmap", 'latest.yml',
  "MakerForge-Setup-Lite-$Version.exe", "MakerForge-Setup-Lite-$Version.exe.blockmap", 'lite.yml'
) | ForEach-Object { Join-Path $dist $_ }
foreach ($f in $update) { if (-not (Test-Path $f)) { throw "File mancante: $f" } }
if (-not (Test-Path $notes)) { throw "Note di rilascio mancanti: $notes" }

# copie con nome fisso per i link "scarica l'ultima versione"
$stable = Join-Path $dist 'stable'
New-Item -ItemType Directory -Force $stable | Out-Null
Copy-Item (Join-Path $dist "MakerForge-Setup-$Version.exe") (Join-Path $stable 'MakerForge-Setup-Windows.exe') -Force
Copy-Item (Join-Path $dist "MakerForge-Setup-Lite-$Version.exe") (Join-Path $stable 'MakerForge-Setup-Windows-Lite.exe') -Force
$assets = $update + @((Join-Path $stable 'MakerForge-Setup-Windows.exe'), (Join-Path $stable 'MakerForge-Setup-Windows-Lite.exe'))

& $gh auth status | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Non sei collegato a GitHub: esegui prima  gh auth login' }
$user = (& $gh api user --jq .login).Trim()

# repository pubblico con solo README e note (niente codice sorgente)
Push-Location $here
try {
  if (-not (Test-Path .git)) { git init -b main | Out-Null }
  git add README.md notes publish-release.ps1
  git diff --cached --quiet
  if ($LASTEXITCODE -ne 0) { git commit -m "MakerForge $Version" | Out-Null }
  & $gh repo view "$user/MakerForge" *> $null
  if ($LASTEXITCODE -ne 0) {
    & $gh repo create MakerForge --public --description 'Laser, CNC e stampa 3D in un''unica app per Windows - download' --source . --remote origin --push
  } else {
    if (-not (git remote 2>$null | Select-String -Quiet '^origin$')) { git remote add origin "https://github.com/$user/MakerForge.git" }
    git push -u origin main
  }
} finally { Pop-Location }

& $gh release create "v$Version" @assets --repo "$user/MakerForge" --title "MakerForge $Version" --notes-file $notes --latest
if ($LASTEXITCODE -ne 0) { throw 'Creazione della release non riuscita' }
Write-Host ""
Write-Host "Pagina della release: https://github.com/$user/MakerForge/releases/latest"
Write-Host "Download diretto:     https://github.com/$user/MakerForge/releases/latest/download/MakerForge-Setup-Windows.exe"
