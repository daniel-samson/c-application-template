# C Application Template

A professional C project template with modern development practices and tooling.

[![Continuous Integration](https://github.com/daniel-samson/c-application-template/actions/workflows/continuous-integration.yml/badge.svg)](https://github.com/daniel-samson/c-application-template/actions/workflows/continuous-integration.yml)
[![Coverage](https://codecov.io/gh/daniel-samson/c-application-template/branch/main/graph/badge.svg)](https://codecov.io/gh/daniel-samson/c-application-template)


# Features

- 🚀 Modern C17 standard with strict compiler warnings
- 📦 CMake Fetch for Package Management
- 🧪 Comprehensive testing with Unity framework
- 📊 Code coverage reporting with llvm-cov
- 📝 Automatic documentation generation with Doxygen
- 🔧 Code formatting and linting tools
- 🏗️ Cross-platform CMake build system
- 🔄 Automated CI/CD with GitHub Actions
- 💻 Multiple IDE support
- 📁 Professional project structure

## Project Structure

```
c-application-template/
├── app/                        # Application entry point
│   └── main.c                  # Main application file
├── src/                        # Library source files
│   └── app.c                   # Core application logic
├── include/                    # Public header files
│   └── app/
│       └── app.h               # Main application header
├── ctest/                      # Unit tests
│   ├── CMakeLists.txt          # Test configuration
│   └── test_applib.c           # Test implementation
├── scripts/                    # Build and utility scripts
│   ├── project.sh              # Main project script (Linux/macOS)
│   ├── project.ps1             # Main project script (Windows)
│   ├── setup-ubuntu-24.04.sh   # Ubuntu dependency installer
│   └── setup-windows.ps1       # Windows dependency installer
├── docs/                       # Documentation
│   ├── Doxyfile.in             # Doxygen configuration
│   └── quick-start-with-clion.md # IDE setup guide
├── .github/                    # GitHub workflows
│   └── workflows/
│       └── continuous-integration.yml # CI/CD pipeline
├── cmake-build-debug/          # Build output (generated)
├── CMakeLists.txt              # Main CMake configuration
├── .clang-format               # Code formatting rules
├── .clang-tidy                 # Static analysis rules
├── .gitignore                  # Git ignore patterns
├── README.md                   # Project documentation
├── CHANGELOG.md                # Version history
└── CONTRIBUTING.md             # Contribution guidelines
```

### Directory Descriptions

- **`app/`** - Contains the main application entry point (`main.c`)
- **`src/`** - Library source files that implement core functionality
- **`include/`** - Public header files that define the API
- **`ctest/`** - Unit tests using the Unity testing framework
- **`scripts/`** - Helper scripts for building, testing, and development
- **`docs/`** - Documentation files and configuration
- **`.github/`** - GitHub Actions workflows for CI/CD
- **`cmake-build-debug/`** - Generated build directory (not in version control)

### Key Files

- **`CMakeLists.txt`** - Main build configuration
- **`project.sh`** - Primary development script for Linux/macOS
- **`project.ps1`** - Primary development script for Windows
- **`setup-ubuntu-24.04.sh`** - Linux dependency installer
- **`setup-windows.ps1`** - Windows dependency installer
- **`.clang-format`** - Automatic code formatting configuration
- **`.clang-tidy`** - Static analysis and linting rules

### Prerequisites

- CMake 3.15 or higher
- C compiler with C17 support (GCC 8+, Clang 9+, MSVC 2019+)
- **Windows users:** PowerShell 5.0+ and a package manager (WinGet, Chocolatey, or Scoop) for automatic setup

### Installation

1. **Clone this template repository:**
   ```bash
   git clone https://github.com/daniel-samson/c-application-template.git myproject
   cd myproject
   ```

2. **Setup dependencies:**
   
   **Linux/macOS:**
   ```bash
   ./scripts/project.sh setup
   ```
   
   **Windows:**
   ```powershell
   .\scripts\project.ps1 setup
   ```

3. **Build the project:**
   
   **Linux/macOS:**
   ```bash
   ./scripts/project.sh build
   ```
   
   **Windows:**
   ```powershell
   .\scripts\project.ps1 build
   ```

4. **Run tests:**
   
   **Linux/macOS:**
   ```bash
   ./scripts/project.sh test
   ```
   
   **Windows:**
   ```powershell
   .\scripts\project.ps1 test
   ```

## Development Workflow

### Building

**Linux/macOS:**
```bash
# Setup and build everything
./scripts/project.sh all

# Individual commands
./scripts/project.sh setup     # Install dependencies
./scripts/project.sh build     # Build project
./scripts/project.sh test      # Run tests
./scripts/project.sh docs      # Generate documentation
```

**Windows:**
```powershell
# Setup and build everything
.\scripts\project.ps1 all

# Individual commands
.\scripts\project.ps1 setup     # Install dependencies
.\scripts\project.ps1 build     # Build project
.\scripts\project.ps1 test      # Run tests
.\scripts\project.ps1 docs      # Generate documentation
```

### Code Quality

**Linux/macOS:**
```bash
# Format code
./scripts/project.sh format

# Run static analysis
./scripts/project.sh lint

# Generate coverage report
./scripts/project.sh coverage
```

**Windows:**
```powershell
# Format code
.\scripts\project.ps1 format

# Run static analysis
.\scripts\project.ps1 lint

# Generate coverage report
.\scripts\project.ps1 coverage
```

## Testing

The project uses the Unity testing framework. Tests are located in the `ctest/` directory.

**Run all tests:**

**Linux/macOS:**
```bash
./scripts/project.sh test
```

**Windows:**
```powershell
.\scripts\project.ps1 test
```

## Documentation

**Generate documentation with Doxygen:**

**Linux/macOS:**
```bash
./scripts/project.sh docs
```

**Windows:**
```powershell
.\scripts\project.ps1 docs
```

Documentation will be available in `build/docs/html/index.html`.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Support

- 📖 [Documentation](build/docs/html/index.html)
- 🐛 [Issue Tracker](https://github.com/daniel-samson/c-application-template/issues)
- 💬 [Discussions](https://github.com/daniel-samson/c-application-template/discussions)

## Acknowledgments

- Unity testing framework
- CMake build system
- LLVM tools for formatting and analysis
