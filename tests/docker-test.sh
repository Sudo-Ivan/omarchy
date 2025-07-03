#!/bin/bash

set -e

echo "=== Docker-based Omarchy Test ==="

echo "Building Docker test image..."
docker build -f Dockerfile.test -t omarchy-test .

echo "Running Omarchy installation test in container..."
docker run --rm omarchy-test

echo "✓ Docker-based test completed successfully!" 