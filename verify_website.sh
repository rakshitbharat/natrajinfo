#!/bin/bash

echo "=== Website Verification Tool ==="

# Check directory structure
echo -e "\n1. Directory Structure:"
tree natraj_website --filelimit 20

# Check for common web files
echo -e "\n2. File Statistics:"
echo "HTML files: $(find natraj_website -name "*.html" | wc -l)"
echo "CSS files: $(find natraj_website -name "*.css" | wc -l)"
echo "JavaScript files: $(find natraj_website -name "*.js" | wc -l)"
echo "Images: $(find natraj_website -name "*.jpg" -o -name "*.png" -o -name "*.gif" | wc -l)"

# Check for external dependencies
echo -e "\n3. External Dependencies:"
grep -r "http://" natraj_website | grep -v "localhost" | sort | uniq

# Check file permissions
echo -e "\n4. File Permissions:"
ls -lR natraj_website | grep "^-"

echo -e "\n=== Verification Complete ===" 