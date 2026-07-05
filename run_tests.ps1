param(
    [string]$Path = "tests"
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$reportsDir = Join-Path $root "reports"
$screenshotsDir = Join-Path $reportsDir "screenshots"

New-Item -ItemType Directory -Force -Path $reportsDir | Out-Null
New-Item -ItemType Directory -Force -Path $screenshotsDir | Out-Null

$env:SCREENSHOT_DIR = $screenshotsDir

robot --outputdir $reportsDir --log log.html --report report.html --output output.xml $Path
