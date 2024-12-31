#!/bin/bash

echo "=== GitHub Pages Setup Verification ==="

# Check DNS resolution
echo -e "\n1. Checking DNS resolution:"
dig natrajinfo.in +noall +answer

# Check HTTPS certificate
echo -e "\n2. Checking HTTPS certificate:"
curl -vI https://natrajinfo.in 2>&1 | grep "SSL certificate"

# Check GitHub Pages connection
echo -e "\n3. Checking GitHub Pages connection:"
curl -I https://natrajinfo.in | grep "Server: GitHub.com"

echo -e "\n=== Verification Complete ===" 