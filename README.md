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
