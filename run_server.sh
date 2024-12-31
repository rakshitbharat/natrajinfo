#!/bin/bash

# Check if natraj_website directory exists
if [ ! -d "natraj_website/natrajinfo.in" ]; then
    echo "Error: Website files not found!"
    echo "Please run download_website.sh first"
    exit 1
fi

# Change to the website directory where the actual files are
cd natraj_website/natrajinfo.in

# Function to check website assets
check_assets() {
    echo "=== Checking Website Assets ==="
    echo "1. Checking for HTML files:"
    find . -name "*.html" | head -n 5
    
    echo -e "\n2. Checking for CSS files:"
    find . -name "*.css" | head -n 5
    
    echo -e "\n3. Checking for JavaScript files:"
    find . -name "*.js" | head -n 5
    
    echo -e "\n4. Checking for Images:"
    find . -name "*.jpg" -o -name "*.png" -o -name "*.gif" | head -n 5
    
    echo -e "\n5. Checking file sizes:"
    du -sh ./*
    
    echo -e "\n6. Checking for any remaining external URLs:"
    grep -r "http://" . | grep -v "localhost" | head -n 5
    
    echo -e "\n=== Asset Check Complete ==="
}

# Run the asset check
check_assets

echo -e "\nStarting Python HTTP Server..."
echo "Access the website at: http://localhost:8000"
echo "Main page URLs:"
echo "- http://localhost:8000/Home%20Page.aspx.html"
echo "- http://localhost:8000/index.html"

# Start server with simpler logging
python3 -m http.server 8000 2>&1 | while read line; do
    echo "$line"
    if [[ $line == *"404"* ]]; then
        echo "[ERROR] 404 Not Found: $line" >&2
    fi
done 