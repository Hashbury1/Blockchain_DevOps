# Windows PowerShell script for setting up development environment

# Enable TLS 1.2 for secure downloads
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install Chocolatey (package manager for Windows)
Write-Host "Installing Chocolatey package manager..."
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install dependencies
Write-Host "Installing dependencies (git, curl, rustup)..."
choco install -y git curl rustup.install

# Add Rust to PATH
$env:Path += ";$env:USERPROFILE\.cargo\bin"

# Install Foundry
Write-Host "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | powershell
foundryup

# Verify installations
Write-Host "Verifying installations..."
rustc --version
cargo --version
forge --version

# Create project directories
Write-Host "Setting up project directories..."
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\projects\ethereum\contracts"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\projects\ethereum\scripts"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\projects\ethereum\tests"
Set-Location "$env:USERPROFILE\projects\ethereum"

# Clone example repositories (optional)
Write-Host "Cloning example repositories..."
git clone https://github.com/foundry-rs/forge-template.git template
git clone https://github.com/foundry-rs/foundry.git foundry-repo

# Initialize new Foundry project
Write-Host "Initializing new Foundry project..."
forge init my_project
Set-Location my_project

# Install dependencies
Write-Host "Installing common dependencies..."
forge install openzeppelin/openzeppelin-contracts

Write-Host "Setup complete! Your development environment is ready."