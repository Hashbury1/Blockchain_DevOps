#!/bin/bash

# Exit on error and print commands
set -ex

# Configuration
CONTRACTS_DIR="src"
TESTS_DIR="test"
DEPLOYMENTS_DIR="deployments"
NETWORK=${NETWORK:-"localhost"}
RPC_URL=${RPC_URL:-"http://localhost:8545"}
VERIFY=${VERIFY:-false}
GAS_REPORT=${GAS_REPORT:-false}

# Function to build contracts
build() {
    echo "🔨 Building contracts..."
    forge build --optimize --optimize-runs 200

    if [ "$GAS_REPORT" = true ]; then
        echo "📊 Generating gas report..."
        forge test --gas-report
    fi
}

# Function to run tests
test() {
    echo "🧪 Running tests..."
    forge test -vvv --fork-url "$RPC_URL"

    # Alternative for coverage (requires lcov)
    # forge coverage --report lcov
}

# Function to deploy contracts
deploy() {
    echo "🚀 Deploying to $NETWORK..."

    mkdir -p "$DEPLOYMENTS_DIR/$NETWORK"

    # Load deployment configuration
    source .env

    # Deploy your contracts (example)
    forge script script/Deploy.s.sol:Deploy \
        --rpc-url "$RPC_URL" \
        --broadcast \
        --verify \
        -vvvv \
        --slow

    # Save deployment addresses
    jq '{contracts: .transactions | map({key: .contractName, value: .contractAddress}) | from_entries}' \
        broadcast/Deploy.s.sol/*/run-latest.json > "$DEPLOYMENTS_DIR/$NETWORK/addresses.json"

    echo "✅ Deployment complete! Addresses saved to $DEPLOYMENTS_DIR/$NETWORK/addresses.json"
}

# Function to clean artifacts
clean() {
    echo "🧹 Cleaning build artifacts..."
    forge clean
    rm -rf "$DEPLOYMENTS_DIR"
}

# Function to format code
format() {
    echo "🎨 Formatting code..."
    forge fmt
}

# Main function
main() {
    case "$1" in
        build)
            build
            ;;
        test)
            test
            ;;
        deploy)
            deploy
            ;;
        all)
            build
            test
            deploy
            ;;
        clean)
            clean
            ;;
        format)
            format
            ;;
        *)
            echo "Usage: $0 {build|test|deploy|all|clean|format}"
            echo "Environment variables:"
            echo "  NETWORK    - Target network (default: localhost)"
            echo "  RPC_URL    - RPC endpoint (default: http://localhost:8545)"
            echo "  VERIFY     - Verify contracts on Etherscan (default: false)"
            echo "  GAS_REPORT - Generate gas report (default: false)"
            exit 1
            ;;
    esac
}

main "$@"