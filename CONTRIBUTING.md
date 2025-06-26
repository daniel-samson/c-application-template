# Contributing to App

First off, thanks for taking the time to contribute! 🎉

The following is a set of guidelines for contributing to App. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

### Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, sex characteristics, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples to demonstrate the steps**
- **Describe the behavior you observed and what behavior you expected**
- **Include details about your configuration and environment**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a step-by-step description of the suggested enhancement**
- **Provide specific examples to demonstrate the steps**
- **Describe the current behavior and explain the behavior you expected**
- **Explain why this enhancement would be useful**

### Your First Code Contribution

Unsure where to begin contributing? You can start by looking through these `beginner` and `help-wanted` issues:

- **Beginner issues** - issues which should only require a few lines of code, and a test or two
- **Help wanted issues** - issues which should be a bit more involved than beginner issues

## Development Setup

### Prerequisites

- CMake 3.21 or higher
- C compiler with C17 support (GCC 8+, Clang 9+, MSVC 2019+)
- Conan package manager
- Python 3.6+ (for Conan)
- Git

### Setting Up Your Development Environment

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/App.git
   cd App
   ```
3. **Set up the development environment**:
   ```bash
   ./scripts/project.sh setup
   ```
4. **Create a topic branch** from main:
   ```bash
   git checkout -b feature/my-new-feature
   ```

### Building and Testing

```bash
# Build the project
./scripts/project.sh build

# Run tests
./scripts/project.sh test

# Run all quality checks
./scripts/project.sh format
./scripts/project.sh lint
./scripts/project.sh coverage
```

## Style Guidelines

### C Code Style

We use Clang Format for consistent code formatting. The configuration is in `.clang-format`.

**Key style points:**
- Use 4 spaces for indentation (no tabs)
- Line length limit of 100 characters
- Linux-style braces
- Function and variable names in `snake_case`
- Constants and macros in `UPPER_CASE`
- Comprehensive documentation with Doxygen comments

**Example:**
```c
/**
 * @brief Adds two integers
 * 
 * @param a First integer
 * @param b Second integer
 * @return The sum of a and b
 */
int add(int a, int b) {
    return a + b;
}
```

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

### Documentation

- All public functions must have Doxygen documentation
- Include examples in documentation when helpful
- Update README.md if your changes affect usage
- Update CHANGELOG.md following the Keep a Changelog format

## Pull Request Process

1. **Ensure your code follows the style guidelines**
2. **Update documentation** if necessary
3. **Add or update tests** for your changes
4. **Ensure all tests pass**:
   ```bash
   ./scripts/project.sh test
   ```
5. **Run code quality checks**:
   ```bash
   ./scripts/project.sh format
   ./scripts/project.sh lint
   ```
6. **Update CHANGELOG.md** with details of changes
7. **Create a pull request** with:
    - Clear title and description
    - Reference to related issues
    - Screenshots if applicable
    - Checklist completion

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Code coverage maintained or improved

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] Any dependent changes have been merged and published
```

## Issue Reporting

### Bug Reports

Use the bug report template:

```markdown
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Environment:**
- OS: [e.g. Ubuntu 20.04]
- Compiler: [e.g. GCC 9.4]
- CMake version: [e.g. 3.21.0]
- Conan version: [e.g. 1.59.0]

**Additional context**
Add any other context about the problem here.
```

### Feature Requests

Use the feature request template:

```markdown
**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is.

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
```

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- GitHub contributors page

Thank you for contributing! 🚀 