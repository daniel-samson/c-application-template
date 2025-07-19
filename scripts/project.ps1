# C Application Template Project Script for Windows
# This script provides common development tasks for Windows

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

# Project paths
$PROJECT_ROOT = Split-Path -Parent $PSScriptRoot
$BUILD_DIR = Join-Path $PROJECT_ROOT "cmake-build-debug"

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

function Show-Usage {
    Write-Host "Usage: .\project.ps1 [COMMAND]"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  setup          - Setup the project (install dependencies)"
    Write-Host "  build          - Build the project"
    Write-Host "  build-coverage - Build project with coverage enabled"
    Write-Host "  test           - Run tests"
    Write-Host "  clean          - Clean build artifacts"
    Write-Host "  format         - Format code with clang-format"
    Write-Host "  lint           - Run clang-tidy"
    Write-Host "  coverage       - Generate code coverage report"
    Write-Host "  docs           - Generate documentation"
    Write-Host "  install        - Install the project"
    Write-Host "  all            - Run setup, build, test, and docs"
    Write-Host "  help           - Show this help message"
}

function Setup-Project {
    Write-Info "Setting up project dependencies..."
    
    Set-Location $PROJECT_ROOT
    
    # Check for setup script
    $setupScript = Join-Path $PROJECT_ROOT "scripts\setup-windows.ps1"
    if (Test-Path $setupScript) {
        Write-Info "Running Windows setup script..."
        & $setupScript
    } else {
        Write-Error "Setup script not found: $setupScript"
        exit 1
    }
    
    Write-Success "Project setup completed"
}

function Build-Project {
    Write-Info "Building project..."
    
    if (-not (Test-Path $BUILD_DIR)) {
        New-Item -ItemType Directory -Path $BUILD_DIR -Force | Out-Null
    }
    
    Set-Location $BUILD_DIR
    
    # Configure CMake
    cmake .. -DCMAKE_BUILD_TYPE=Debug
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "CMake configuration failed"
        exit 1
    }
    
    # Build project
    $cores = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfLogicalProcessors
    cmake --build . --parallel $cores
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Build failed"
        exit 1
    }
    
    Write-Success "Build completed"
}

function Run-Tests {
    Write-Info "Running tests..."
    
    Build-Project
    Set-Location $BUILD_DIR
    ctest --extra-verbose
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Tests failed"
        exit 1
    }
    
    Write-Success "Tests completed"
}

function Clean-Project {
    Write-Info "Cleaning build artifacts..."
    
    if (Test-Path $BUILD_DIR) {
        Remove-Item -Path $BUILD_DIR -Recurse -Force
        Write-Success "Build directory cleaned"
    } else {
        Write-Warning "Build directory does not exist"
    }
}

function Format-Code {
    Write-Info "Formatting code with clang-format..."
    
    Set-Location $PROJECT_ROOT
    
    # Find all C source and header files
    $files = Get-ChildItem -Path . -Recurse -Include "*.c", "*.h" | 
             Where-Object { $_.FullName -match "(app|src|include)" } |
             Where-Object { $_.FullName -notmatch "(_deps|cmake-build|ctest)" }
    
    if ($files.Count -eq 0) {
        Write-Warning "No C source files found to format"
        return
    }
    
    foreach ($file in $files) {
        clang-format -i $file.FullName
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Failed to format $($file.Name)"
        }
    }
    
    Write-Success "Code formatting completed"
}

function Run-Lint {
    Write-Info "Running clang-tidy..."
    
    Set-Location $BUILD_DIR
    
    # Ensure compile_commands.json exists
    if (-not (Test-Path "compile_commands.json")) {
        Write-Error "compile_commands.json not found. Please build the project first."
        exit 1
    }
    
    # Run clang-tidy on source files
    $files = Get-ChildItem -Path $PROJECT_ROOT -Recurse -Include "*.c" |
             Where-Object { $_.FullName -match "(app|src|include)" } |
             Where-Object { $_.FullName -notmatch "(_deps|cmake-build|ctest)" }
    
    foreach ($file in $files) {
        clang-tidy -p . $file.FullName
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Linting issues found in $($file.Name)"
        }
    }
    
    Write-Success "Linting completed"
}

function Generate-Coverage {
    Write-Info "Generating code coverage report..."
    Write-Warning "Note: Code coverage on Windows requires OpenCppCoverage or similar tools"
    Write-Warning "LLVM coverage may not work as expected on Windows"
    
    # Clean and create build directory
    if (Test-Path $BUILD_DIR) {
        Remove-Item -Path $BUILD_DIR -Recurse -Force
    }
    New-Item -ItemType Directory -Path $BUILD_DIR -Force | Out-Null
    Set-Location $BUILD_DIR
    
    # Detect compiler and set up coverage accordingly
    if (Get-Command gcc -ErrorAction SilentlyContinue) {
        Write-Info "Using GCC for coverage..."
        cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON -DCMAKE_C_COMPILER=gcc
    } elseif (Get-Command clang -ErrorAction SilentlyContinue) {
        Write-Info "Using Clang for coverage..."
        cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON -DCMAKE_C_COMPILER=clang
    } else {
        Write-Error "No suitable compiler found for coverage"
        exit 1
    }
    
    # Build with coverage flags
    $cores = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfLogicalProcessors
    cmake --build . --parallel $cores
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Coverage build failed"
        exit 1
    }
    
    # Run tests to generate coverage data
    Write-Info "Running tests to generate coverage data..."
    ctest --output-on-failure
    
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Some tests failed, coverage data may be incomplete"
    }
    
    # Try to generate coverage report
    if (-not (Test-Path "coverage")) {
        New-Item -ItemType Directory -Path "coverage" -Force | Out-Null
    }
    
    Write-Info "Coverage data generated. For HTML reports, consider using:"
    Write-Info "  - OpenCppCoverage: https://github.com/OpenCppCoverage/OpenCppCoverage"
    Write-Info "  - Visual Studio Code Coverage"
    Write-Info "  - JetBrains CLion built-in coverage"
    
    Write-Success "Coverage generation completed (Windows limitations apply)"
}

function Generate-Docs {
    Write-Info "Generating documentation..."
    
    Set-Location $BUILD_DIR
    
    if (Get-Command doxygen -ErrorAction SilentlyContinue) {
        cmake --build . --target docs
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Documentation generated in build/docs/"
        } else {
            Write-Error "Documentation generation failed"
            exit 1
        }
    } else {
        Write-Error "Doxygen not found"
        exit 1
    }
}

function Install-Project {
    Write-Info "Installing project..."
    
    Set-Location $BUILD_DIR
    
    # Check if running as administrator
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if (-not $isAdmin) {
        Write-Warning "Administrator privileges may be required for installation"
        $response = Read-Host "Continue anyway? (y/N)"
        if ($response -ne "y" -and $response -ne "Y") {
            Write-Info "Installation cancelled"
            return
        }
    }
    
    cmake --install .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Installation completed"
    } else {
        Write-Error "Installation failed"
        exit 1
    }
}

function Run-All {
    Setup-Project
    Build-Project
    Run-Tests
    Generate-Docs
}

function Build-Coverage {
    Write-Info "Building project with coverage..."
    
    if (-not (Test-Path $BUILD_DIR)) {
        New-Item -ItemType Directory -Path $BUILD_DIR -Force | Out-Null
    }
    
    Set-Location $BUILD_DIR
    
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "CMake configuration failed"
        exit 1
    }
    
    $cores = (Get-WmiObject -Class Win32_ComputerSystem).NumberOfLogicalProcessors
    cmake --build . --parallel $cores
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Coverage build completed"
    } else {
        Write-Error "Coverage build failed"
        exit 1
    }
}

# Main script logic
switch ($Command.ToLower()) {
    "setup" {
        Setup-Project
    }
    "build" {
        Build-Project
    }
    "build-coverage" {
        Build-Coverage
    }
    "test" {
        Run-Tests
    }
    "clean" {
        Clean-Project
    }
    "format" {
        Format-Code
    }
    "lint" {
        Run-Lint
    }
    "coverage" {
        Generate-Coverage
    }
    "docs" {
        Generate-Docs
    }
    "install" {
        Install-Project
    }
    "all" {
        Run-All
    }
    "help" {
        Show-Usage
    }
    default {
        Write-Error "Unknown command: $Command"
        Show-Usage
        exit 1
    }
} 