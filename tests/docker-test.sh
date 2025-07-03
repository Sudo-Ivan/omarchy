#!/bin/bash

set -e

echo "=== Docker-based Omarchy Test ==="

# Create Dockerfile for testing
cat > Dockerfile.test << 'EOF'
FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git curl wget base-devel sudo && \
    useradd -m -G wheel testuser && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

COPY . /home/testuser/omarchy-test

CMD ["/bin/bash", "-c", "cd /home/testuser && curl -s https://raw.githubusercontent.com/Sudo-Ivan/omarchy/refs/heads/master/boot.sh | bash && echo 'Omarchy installation test completed'"]
EOF

echo "Building Docker test image..."
docker build -f Dockerfile.test -t omarchy-test .

echo "Running Omarchy installation test in container..."
docker run --rm omarchy-test

echo "✓ Docker-based test completed successfully!"

# Cleanup
rm -f Dockerfile.test 