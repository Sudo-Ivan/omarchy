#!/bin/bash

set -e

echo "=== Docker-based Omarchy Test ==="

# Create Dockerfile for testing
cat > Dockerfile.test << 'EOF'
FROM archlinux:latest

# Initialize pacman keyring and update system
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm git curl wget base-devel sudo haveged

# Start entropy daemon for GPG operations
RUN systemctl enable haveged || true

# Create test user
RUN useradd -m -G wheel testuser && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Initialize user GPG if needed
RUN gpg --batch --gen-key << 'GPGEOF'
%echo Generating test key
Key-Type: RSA
Key-Length: 2048
Name-Real: Test User
Name-Email: test@example.com
Expire-Date: 0
%no-protection
%commit
%echo done
GPGEOF

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