param(
    [string]$Path = "tests",
    [switch]$Allure,
    [switch]$Extent
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$reportsDir = Join-Path $root "reports"
$screenshotsDir = Join-Path $reportsDir "screenshots"
$allureResultsDir = Join-Path $reportsDir "allure-results"
$allureReportDir = Join-Path $reportsDir "allure-report"
$extentReportFile = Join-Path $reportsDir "extent-report.html"

New-Item -ItemType Directory -Force -Path $reportsDir | Out-Null
New-Item -ItemType Directory -Force -Path $screenshotsDir | Out-Null
New-Item -ItemType Directory -Force -Path $allureResultsDir | Out-Null

$env:SCREENSHOT_DIR = $screenshotsDir

$logFile = Join-Path $reportsDir "log.html"
$reportFile = Join-Path $reportsDir "report.html"
$outputFile = Join-Path $reportsDir "output.xml"

$listenerArgs = @()
if ($Allure) {
    $listenerArgs += "--listener"
    $listenerArgs += "allure_robotframework:$allureResultsDir"
}

$robotArgs = @(
    "--outputdir", $reportsDir,
    "--log", $logFile,
    "--report", $reportFile,
    "--output", $outputFile
) + $listenerArgs + @($Path)

robot @robotArgs

if ($Allure) {
    $allureCmd = Get-Command allure -ErrorAction SilentlyContinue
    $allureExe = $null
    if ($null -ne $allureCmd) {
        $allureExe = $allureCmd.Source
    }
    else {
        $toolsDir = Join-Path $root "tools"
        $localAllureDir = Join-Path $toolsDir "allure"
        $localAllureExe = Join-Path $localAllureDir "bin\allure.bat"
        if (-not (Test-Path $localAllureExe)) {
            Write-Host "Allure CLI not found in PATH. Downloading local Allure CLI..."
            New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null
            $allureZip = Join-Path $toolsDir "allure.zip"
            $downloadUrl = "https://github.com/allure-framework/allure2/releases/download/2.24.0/allure-2.24.0.zip"
            Invoke-WebRequest -Uri $downloadUrl -OutFile $allureZip -UseBasicParsing
            Expand-Archive -Path $allureZip -DestinationPath $toolsDir -Force
            Remove-Item -Path $allureZip -Force
            $downloadedDir = Join-Path $toolsDir "allure-2.24.0"
            if (Test-Path $downloadedDir) {
                if (Test-Path $localAllureDir) { Remove-Item -Recurse -Force $localAllureDir }
                Rename-Item -Path $downloadedDir -NewName "allure"
            }
        }
        if (Test-Path $localAllureExe) {
            $allureExe = $localAllureExe
        }
    }

    if ($null -ne $allureExe) {
        Write-Host "Generating Allure HTML report..."
        & $allureExe generate $allureResultsDir -o $allureReportDir --clean
        Write-Host "Allure report generated at: $allureReportDir"
    }
    else {
        Write-Host "Allure CLI not found. Install it separately to generate the HTML report."
        Write-Host "Use 'allure serve $allureResultsDir' after installing Allure CLI."
    }
}

if ($Extent) {
    Write-Host "Generating Extent-style HTML report..."
    C:/Python314/python.exe "$root\generate_extent_report.py" -i $outputFile -o $extentReportFile
    Write-Host "Extent-style report generated at: $extentReportFile"
}
