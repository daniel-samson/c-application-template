#!/bin/bash
set -e

# Install pre-requisites
echo "Installing pre-requisites. We will need to use sudo to install it."

## Install dependencies
sudo apt-get update
sudo apt-get install -y build-essential clang clang-tidy clang-format cmake git wget doxygen python3 llvm lcov