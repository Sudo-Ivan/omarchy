#!/bin/bash

set -e

echo "=== Omarchy CI Test Suite ==="

# Cleanup function
cleanup() {
    echo "Cleaning up..."
    pkill -f qemu-system-x86_64 || true
    rm -f archlinux.iso arch-vm.qcow2 install-arch.sh qemu-monitor-socket
}

# Set trap for cleanup
trap cleanup EXIT

# Make scripts executable
chmod +x setup-arch.sh test-omarchy.sh

echo "Step 1: Setting up Arch Linux VM..."
./setup-arch.sh

echo "Step 2: Testing Omarchy installation..."
./test-omarchy.sh

echo "✓ All tests passed!" 