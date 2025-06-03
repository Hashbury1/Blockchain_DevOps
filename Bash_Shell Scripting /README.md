# Web3 Development Environment Setup
This repository contains scripts to quickly set up a foundational development environment for Web3 projects, focusing on smart contract development with Foundry.

# 🚀 Quick Start
To get your Web3 development environment up and running, follow the instructions for your operating system.

# For Linux/macOS
Save the setup script:
Save the content of the setup_dev.sh script into a file named setup_dev.sh in your desired directory.

Make it executable:

Bash

chmod +x setup_dev.sh
Run the script:

Bash


./Windows_setup_dev.sh
For Windows
Save the setup script:
Save the content of the setup_dev.ps1 script into a file named setup_dev.ps1 in your desired directory.

# Run it in PowerShell:
Open PowerShell and execute:

PowerShell

.\setup_dev.ps1
What the Scripts Do
These scripts automate the installation of essential tools and set up a basic project structure for your Web3 development.

# 🛠️ Tool Installation
The scripts handle the installation of:

curl and git: Fundamental command-line tools for network requests and version control.
Rust: Installed via rustup, which is a prerequisite for Foundry.
Foundry: The blazing fast smart contract development toolkit, installed using foundryup.


# 📂 Project Setup
The scripts will:

# Create a standard directory structure common for Ethereum projects.
Optionally clone example repositories to provide helpful references.
Initialize a new Foundry project using the forge init command.
📦 Dependency Management
Common smart contract dependencies are automatically installed, including:

OpenZeppelin Contracts: A widely used library for secure smart contract development.
# ⚙️ Customization Tips
Feel free to modify the scripts to better suit your workflow:

Project Structure: Adjust the directory creation commands (mkdir) to align with your preferred project layout.
Example Repositories: Change the git clone commands to include your own or your team's frequently used repositories.
Dependencies: Add more forge install commands to include other common smart contract libraries or dependencies you use regularly.

# ⚠️ Safety Considerations
Review Before Running: Always inspect the contents of any script before executing it, especially those that use patterns like curl | bash. Understand every command it performs.
Version Pinning: For highly reproducible environments, consider pinning specific versions of tools (e.g., Rust, Foundry) rather than always installing the latest. This can be done by specifying versions in the installation commands.
Containerization: For team environments or more complex setups, consider containerizing your development environment using Docker. This ensures consistency across all developer machines.