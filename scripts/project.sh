#!/bin/bash

# MyProject Helper Script
# This script provides common development tasks

set -e  # Exit on any error

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${PROJECT_ROOT}/cmake-build-debug"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Show usage
show_usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  setup          - Setup the project (install dependencies)"
    echo "  build          - Build the project"
    echo "  build-coverage - Build project with coverage enabled"
    echo "  test           - Run tests"
    echo "  clean          - Clean build artifacts"
    echo "  format         - Format code with clang-format"
    echo "  lint           - Run clang-tidy"
    echo "  coverage       - Generate code coverage report"
    echo "  docs           - Generate documentation"
    echo "  install        - Install the project"
    echo "  all            - Run setup, build, test, and docs"
    echo "  help           - Show this help message"
}

# Setup project dependencies
setup_project() {
    print_info "Setting up project dependencies..."

    cd "${PROJECT_ROOT}"

    # Detect operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_info "Detected macOS, using Homebrew setup script..."
        ./scripts/setup-macos.sh
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_info "Detected Linux, using Ubuntu setup script..."
        ./scripts/setup-ubuntu-24.04.sh
    else
        print_error "Unsupported operating system: $OSTYPE"
        print_error "Please run the appropriate setup script manually:"
        print_error "  - For macOS: ./scripts/setup-macos.sh"
        print_error "  - For Ubuntu: ./scripts/setup-ubuntu-24.04.sh"
        exit 1
    fi

    print_success "Project setup completed"
}

# Build the project
build_project() {
    print_info "Building project..."

    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"

    # Use the Conan-generated toolchain file
    cmake .. -DENABLE_ASAN=ON -DCMAKE_BUILD_TYPE=Debug

    cmake --build . --parallel $(nproc)

    print_success "Build completed"
}

# Run tests
run_tests() {
    print_info "Running tests..."

    build_project
    cd "${BUILD_DIR}"
    ctest --extra-verbose

    print_success "Tests completed"
}

# Clean build artifacts
clean_project() {
    print_info "Cleaning build artifacts..."

    if [ -d "${BUILD_DIR}" ]; then
        rm -rf "${BUILD_DIR}"
        print_success "Build directory cleaned"
    else
        print_warning "Build directory does not exist"
    fi
}

# Format code
format_code() {
    print_info "Formatting code with clang-format..."

    cd "${PROJECT_ROOT}"

    # Find all C source and header files
    find . -name "*.c" -o -name "*.h" | grep -E "(app|src|include|tests|examples|benchmarks)" | xargs clang-format -i

    print_success "Code formatting completed"
}

# Run linting
run_lint() {
    print_info "Running clang-tidy..."

    cd "${BUILD_DIR}"

    # Ensure compile_commands.json exists
    if [ ! -f "compile_commands.json" ]; then
        print_error "compile_commands.json not found. Please build the project first."
        exit 1
    fi

    # Run clang-tidy on source files, excluding dependencies and tests
    find "${PROJECT_ROOT}" -name "*.c" \
        | grep -E "(app|src|include)" \
        | grep -v "_deps" \
        | grep -v "cmake-build" \
        | grep -v "ctest" \
        | xargs clang-tidy -p .

    print_success "Linting completed"
}

# Generate coverage report
generate_coverage() {
    print_info "Generating code coverage report..."

    # Clean and create build directory
    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"

    # Detect compiler and set up coverage accordingly
    if command -v gcc >/dev/null 2>&1; then
        print_info "Using GCC for coverage..."
        COVERAGE_TOOL="gcov"
        cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON -DCMAKE_C_COMPILER=gcc
    elif command -v clang >/dev/null 2>&1; then
        print_info "Using Clang for coverage..."
        COVERAGE_TOOL="llvm"
        cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON -DCMAKE_C_COMPILER=clang
    else
        print_error "No suitable compiler found for coverage"
        exit 1
    fi

    # Build with coverage flags
    cmake --build . --parallel $(nproc)

    # Run tests to generate coverage data
    print_info "Running tests to generate coverage data..."
    if [ "$COVERAGE_TOOL" = "llvm" ]; then
        # For Clang, set environment variable for profile output
        export LLVM_PROFILE_FILE="coverage.profraw"
    fi
    
    ctest --output-on-failure

    # Generate coverage report based on tool
    if [ "$COVERAGE_TOOL" = "gcov" ]; then
        generate_gcov_report
    elif [ "$COVERAGE_TOOL" = "llvm" ]; then
        generate_llvm_report
    fi
}

# Generate GCC/gcov coverage report
generate_gcov_report() {
    print_info "Generating gcov coverage report..."
    
    # Create coverage directory
    mkdir -p coverage
    
    if command -v lcov >/dev/null 2>&1; then
        # Use lcov for better HTML reports
        lcov --capture --directory . --output-file coverage/coverage.info
        lcov --ignore-errors unused --remove coverage/coverage.info '/usr/*' '*/_deps/*' '*/ctest/*' --output-file coverage/coverage.info
        lcov --list coverage/coverage.info
        
        if command -v genhtml >/dev/null 2>&1; then
            genhtml coverage/coverage.info --output-directory coverage/html
            print_success "HTML coverage report generated in ${BUILD_DIR}/coverage/html/"
        fi
    else
        # Fallback to basic gcov
        find . -name "*.gcno" -exec gcov {} \;
        mkdir -p coverage/gcov
        mv *.gcov coverage/gcov/ 2>/dev/null || true
        print_success "gcov files generated in ${BUILD_DIR}/coverage/gcov/"
    fi
}

# Generate LLVM coverage report
generate_llvm_report() {
    print_info "Generating LLVM coverage report..."
    
    if command -v llvm-profdata >/dev/null 2>&1 && command -v llvm-cov >/dev/null 2>&1; then
        # Merge profile data
        llvm-profdata merge -sparse coverage.profraw -o coverage.profdata
        
        # Create coverage directory
        mkdir -p coverage
        
        # Generate text report
        llvm-cov report ctest/test_app -instr-profile=coverage.profdata > coverage/coverage.txt
        
        # Generate HTML report
        llvm-cov show ctest/test_app -instr-profile=coverage.profdata -format=html -output-dir=coverage/html
        
        # Show summary
        llvm-cov report ctest/test_app -instr-profile=coverage.profdata
        
        print_success "Coverage report generated in ${BUILD_DIR}/coverage/"
    else
        print_error "llvm-cov tools not found. Install with: apt install llvm"
        exit 1
    fi
}

# Generate documentation
generate_docs() {
    print_info "Generating documentation..."

    cd "${BUILD_DIR}"

    if command -v doxygen >/dev/null 2>&1; then
        cmake --build . --target docs
        print_success "Documentation generated in build/docs/"
    else
        print_error "Doxygen not found"
        exit 1
    fi
}

# Install the project
install_project() {
    print_info "Installing project..."

    cd "${BUILD_DIR}"
    sudo cmake --install .

    print_success "Installation completed"
}

# Run all tasks
run_all() {
    setup_project
    build_project
    run_tests
    generate_docs
}

# Build with coverage
build_coverage() {
    print_info "Building project with coverage..."

    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"

    cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON
    cmake --build . --parallel $(nproc)

    print_success "Coverage build completed"
}

# Main script logic
case "${1:-help}" in
    setup)
        setup_project
        ;;
    build)
        build_project
        ;;
    build-coverage)
        build_coverage
        ;;
    test)
        run_tests
        ;;
    clean)
        clean_project
        ;;
    format)
        format_code
        ;;
    lint)
        run_lint
        ;;
    coverage)
        generate_coverage
        ;;
    docs)
        generate_docs
        ;;
    install)
        install_project
        ;;
    all)
        run_all
        ;;
    help|--help|-h)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        show_usage
        exit 1
        ;;
esac
