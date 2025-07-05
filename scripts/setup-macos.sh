#!/bin/bash
set -e

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install it first by running:"
    echo ""
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo ""
    echo "After installation, you may need to add Homebrew to your PATH:"
    echo "echo 'eval \"\$(/opt/homebrew/bin/brew shellenv)\"' >> ~/.zprofile"
    echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\""
    echo ""
    echo "Then run this script again."
    exit 1
fi

# Install pre-requisites
echo "Installing pre-requisites using Homebrew..."

## Install dependencies
brew update
brew install cmake clang-format git wget doxygen python3 llvm lcov

echo "All dependencies have been installed successfully!"
