#!/bin/bash

# Change to the git repository directory
cd natrajinfo

# Download the website with wget
wget \
    --recursive \
    --no-clobber \
    --page-requisites \
    --html-extension \
    --convert-links \
    --restrict-file-names=unix \
    --domains natrajinfo.in \
    --no-parent \
    http://natrajinfo.in/Home%20Page.aspx

# Create a copy for index.html
if [ -f "natrajinfo.in/Home Page.aspx.html" ]; then
    cp "natrajinfo.in/Home Page.aspx.html" "natrajinfo.in/index.html"
fi

# Add CNAME file for custom domain
echo "natrajinfo.in" > CNAME

# Git commands to push changes
git add .
git commit -m "Update website files"
git push origin gh-pages

echo "Website files updated and pushed to GitHub Pages!" 