#!/bin/bash
set -e

# Install pre-requisites
echo "Installing pre-requisites. We will need to use sudo to install it."

# Update package database
sudo pacman -Sy

# Install dependencies
sudo pacman -S --noconfirm base-devel clang clang-tools-extra cmake git wget doxygen python llvm lcov 