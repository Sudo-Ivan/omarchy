#!/bin/bash

set -e

VM_DISK="arch-vm.qcow2"

echo "Starting VM for Omarchy testing..."
qemu-system-x86_64 \
    -enable-kvm \
    -m 2G \
    -smp 2 \
    -hda "$VM_DISK" \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device e1000,netdev=net0 \
    -nographic \
    -boot c \
    -monitor unix:qemu-monitor-socket,server,nowait &

QEMU_PID=$!

echo "Waiting for VM to boot..."
sleep 30

# Test SSH connection
echo "Testing SSH connection..."
timeout 60 bash -c 'until nc -z localhost 2222; do sleep 1; done'

echo "Running Omarchy installation test..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 testuser@localhost << 'SSH_EOF'
set -e

echo "Starting Omarchy installation test..."

# Test the boot script
curl -s https://raw.githubusercontent.com/Sudo-Ivan/omarchy/refs/heads/master/boot.sh | bash

# Verify installation
if [ -d ~/.local/share/omarchy ]; then
    echo "✓ Omarchy cloned successfully"
else
    echo "✗ Omarchy clone failed"
    exit 1
fi

# Check if install script exists
if [ -f ~/.local/share/omarchy/install.sh ]; then
    echo "✓ Install script found"
else
    echo "✗ Install script not found"
    exit 1
fi

# Test individual install scripts
echo "Testing install script components..."
for script in ~/.local/share/omarchy/install/*.sh; do
    if [ -f "$script" ]; then
        echo "✓ Found: $(basename "$script")"
        # Basic syntax check
        bash -n "$script" && echo "✓ Syntax OK: $(basename "$script")" || echo "✗ Syntax error: $(basename "$script")"
    fi
done

echo "Omarchy installation test completed successfully!"
SSH_EOF

EXIT_CODE=$?

# Clean up
kill $QEMU_PID 2>/dev/null || true
wait $QEMU_PID 2>/dev/null || true

if [ $EXIT_CODE -eq 0 ]; then
    echo "✓ Omarchy test passed!"
else
    echo "✗ Omarchy test failed!"
    exit 1
fi 