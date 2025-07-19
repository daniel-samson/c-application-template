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
│   ├── project.sh              # Main project script
│   └── setup-ubuntu-24.04.sh   # Ubuntu dependency installer
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
- **`project.sh`** - Primary development script with commands for building, testing, etc.
- **`.clang-format`** - Automatic code formatting configuration
- **`.clang-tidy`** - Static analysis and linting rules

### Prerequisites

- CMake 3.15 or higher
- C compiler with C17 support (GCC 8+, Clang 9+, MSVC 2019+)

### Installation

1. **Clone this template repository:**
   ```bash
   git clone https://github.com/daniel-samson/c-application-template.git myproject
   cd myproject
   ```

2. **Setup dependencies:**
   ```bash
   ./scripts/project.sh setup
   ```

3. **Build the project:**
   ```bash
   ./scripts/project.sh build
   ```

4. **Run tests:**
   ```bash
   ./scripts/project.sh test
   ```

## Development Workflow

### Building

```bash
# Setup and build everything
./scripts/project.sh all

# Individual commands
./scripts/project.sh setup     # Install dependencies
./scripts/project.sh build     # Build project
./scripts/project.sh test      # Run tests
./scripts/project.sh docs      # Generate documentation
```

### Code Quality

```bash
# Format code
./scripts/project.sh format

# Run static analysis
./scripts/project.sh lint

# Generate coverage report
./scripts/project.sh coverage
```

## Testing

The project uses the Unity testing framework. Tests are located in the `tests/` directory.

Run all tests:
```bash
./scripts/project.sh test
```

## Documentation

Generate documentation with Doxygen:
```bash
./scripts/project.sh docs
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
- 🐛 [Issue Tracker](https://github.com/username/myproject/issues)
- 💬 [Discussions](https://github.com/username/myproject/discussions)

## Acknowledgments

- Unity testing framework
- CMake build system
- LLVM tools for formatting and analysis
