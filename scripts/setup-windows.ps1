# Windows Setup Script for C Application Template
# This script installs the required dependencies for the C project

param(
    [switch]$Force = $false
)

# Colors for output
$Red = [System.ConsoleColor]::Red
$Green = [System.ConsoleColor]::Green
$Yellow = [System.ConsoleColor]::Yellow
$Blue = [System.ConsoleColor]::Blue

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor $Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor $Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor $Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor $Red
}

function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-PackageManager {
    $packageManagers = @()
    
    # Check for WinGet (Windows Package Manager)
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        $packageManagers += "winget"
    }
    
    # Check for Chocolatey
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        $packageManagers += "chocolatey"
    }
    
    # Check for Scoop
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        $packageManagers += "scoop"
    }
    
    return $packageManagers
}

function Install-WithWinGet {
    Write-Info "Installing dependencies using WinGet..."
    
    $packages = @(
        "Microsoft.VisualStudio.2022.BuildTools",
        "LLVM.LLVM",
        "Kitware.CMake",
        "Git.Git",
        "Python.Python.3.12",
        "DimitriVanHeesch.Doxygen"
    )
    
    foreach ($package in $packages) {
        try {
            Write-Info "Installing $package..."
            winget install --id $package --silent --accept-package-agreements --accept-source-agreements
        }
        catch {
            Write-Warning "Failed to install $package with WinGet"
        }
    }
}

function Install-WithChocolatey {
    Write-Info "Installing dependencies using Chocolatey..."
    
    $packages = @(
        "visualstudio2022buildtools",
        "llvm",
        "cmake",
        "git",
        "python3",
        "doxygen.install"
    )
    
    foreach ($package in $packages) {
        try {
            Write-Info "Installing $package..."
            choco install $package -y
        }
        catch {
            Write-Warning "Failed to install $package with Chocolatey"
        }
    }
}

function Install-WithScoop {
    Write-Info "Installing dependencies using Scoop..."
    
    # Add required buckets
    scoop bucket add main
    scoop bucket add extras
    
    $packages = @(
        "llvm",
        "cmake",
        "git",
        "python",
        "doxygen"
    )
    
    foreach ($package in $packages) {
        try {
            Write-Info "Installing $package..."
            scoop install $package
        }
        catch {
            Write-Warning "Failed to install $package with Scoop"
        }
    }
    
    Write-Warning "Visual Studio Build Tools must be installed manually with Scoop"
    Write-Info "Please install Visual Studio Community or Build Tools from: https://visualstudio.microsoft.com/downloads/"
}

function Show-ManualInstructions {
    Write-Error "No package manager found! Please choose one of the following options:"
    Write-Host ""
    Write-Host "Option 1: Install WinGet (Recommended)" -ForegroundColor $Yellow
    Write-Host "  - WinGet comes with Windows 10 1909+ and Windows 11"
    Write-Host "  - For older Windows: Download from Microsoft Store or GitHub"
    Write-Host "  - GitHub: https://github.com/microsoft/winget-cli/releases"
    Write-Host ""
    Write-Host "Option 2: Install Chocolatey" -ForegroundColor $Yellow
    Write-Host "  - Run as Administrator:"
    Write-Host "  - Set-ExecutionPolicy Bypass -Scope Process -Force"
    Write-Host "  - [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072"
    Write-Host "  - iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    Write-Host ""
    Write-Host "Option 3: Install Scoop" -ForegroundColor $Yellow
    Write-Host "  - Run in PowerShell:"
    Write-Host "  - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    Write-Host "  - irm get.scoop.sh | iex"
    Write-Host ""
    Write-Host "Option 4: Manual Installation" -ForegroundColor $Yellow
    Write-Host "  Required tools:"
    Write-Host "  - Visual Studio 2022 Community or Build Tools"
    Write-Host "  - LLVM (includes clang, clang-format, clang-tidy)"
    Write-Host "  - CMake"
    Write-Host "  - Git"
    Write-Host "  - Python 3"
    Write-Host "  - Doxygen"
    Write-Host ""
    Write-Host "Download links:" -ForegroundColor $Blue
    Write-Host "  - Visual Studio: https://visualstudio.microsoft.com/downloads/"
    Write-Host "  - LLVM: https://github.com/llvm/llvm-project/releases"
    Write-Host "  - CMake: https://cmake.org/download/"
    Write-Host "  - Git: https://git-scm.com/download/win"
    Write-Host "  - Python: https://www.python.org/downloads/"
    Write-Host "  - Doxygen: https://www.doxygen.nl/download.html"
}

# Main script execution
Write-Info "Setting up C Application Template dependencies on Windows..."

# Check if running as administrator for some package managers
if (-not (Test-Administrator)) {
    Write-Warning "Not running as Administrator. Some package managers may require elevated privileges."
    if (-not $Force) {
        $response = Read-Host "Continue anyway? (y/N)"
        if ($response -ne "y" -and $response -ne "Y") {
            Write-Info "Setup cancelled. Run as Administrator for best results."
            exit 1
        }
    }
}

# Detect available package managers
$packageManagers = Test-PackageManager

if ($packageManagers.Count -eq 0) {
    Show-ManualInstructions
    exit 1
}

Write-Info "Found package managers: $($packageManagers -join ', ')"

# Install using the first available package manager
switch ($packageManagers[0]) {
    "winget" {
        Install-WithWinGet
    }
    "chocolatey" {
        Install-WithChocolatey
    }
    "scoop" {
        Install-WithScoop
    }
}

Write-Success "Dependency installation completed!"
Write-Info "Note: You may need to restart your terminal or add tools to your PATH"
Write-Info "Note: For code coverage on Windows, consider using OpenCppCoverage instead of lcov"

# Verify installations
Write-Info "Verifying installations..."
$tools = @("cmake", "git", "python", "clang", "clang-format", "clang-tidy", "doxygen")

foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Success "$tool is available"
    } else {
        Write-Warning "$tool not found in PATH"
    }
}

Write-Success "Windows setup completed!" 