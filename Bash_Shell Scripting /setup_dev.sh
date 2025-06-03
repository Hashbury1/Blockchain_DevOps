#!/bin/bash

# Exit script if any command fails
set -e

# Update package lists
echo "Updating package lists..."
sudo apt-get update -y

# Install basic dependencies
echo "Installing basic dependencies (curl, git, build-essential)..."
sudo apt-get install -y curl git build-essential

# Install Rust using rustup
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust to PATH
source $HOME/.cargo/env

# Install Foundry using foundryup
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash
source $HOME/.bashrc  # Or .zshrc if you use zsh
foundryup

# Verify installations
echo "Verifying installations..."
rustc --version
cargo --version
forge --version

# Create project directory structure
echo "Setting up project directories..."
mkdir -p ~/projects/ethereum/{contracts,scripts,tests}
cd ~/projects/ethereum

# Clone example repositories (optional)
echo "Cloning example repositories..."
git clone https://github.com/foundry-rs/forge-template.git template
git clone https://github.com/foundry-rs/foundry.git foundry-repo

# Initialize a new Foundry project
echo "Initializing new Foundry project..."
forge init my_project
cd my_project

# Install dependencies
echo "Installing common dependencies..."
forge install openzeppelin/openzeppelin-contracts

echo "Setup complete! Your development environment is ready for use."