#!/bin/bash

echo "========== RUST TOOLCHAIN =========="
rustup show
echo "===================================="

# Array of feature names
features=("")

# Calculate the total number of features
total_features=${#features[@]}

# Function to generate combinations of features
generate_combinations() {
    local index=$1
    local combination=$2

    if [ $index -eq $total_features ]; then
        # Run cargo test with the current combination of features
        echo "Running: cargo test --release --features $combination"
        cargo test --release --features "$combination"
        echo "Running: cargo test --features $combination"
        cargo test --features "$combination"
    else
        # Include the current feature in the combination and recurse
        generate_combinations "$((index + 1))" "$combination ${features[index]}"
        # Exclude the current feature and recurse
        generate_combinations "$((index + 1))" "$combination"
    fi
}

# Start generating combinations from index 0
generate_combinations 0 ""

echo "All feature combinations tested successfully."
