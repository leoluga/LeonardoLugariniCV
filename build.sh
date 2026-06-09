#!/bin/bash

# Stop the script if any command fails
set -e

# Check for pdflatex
if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex not found."
    echo "Install MacTeX (full): brew install --cask mactex"
    echo "Install BasicTeX (minimal): brew install --cask basictex"
    exit 1
fi

echo "[1/4] Compiling LaTeX (Pass 1)..."
pdflatex -interaction=nonstopmode LugariniCV.tex

echo "[2/4] Compiling LaTeX (Pass 2)..."
pdflatex -interaction=nonstopmode LugariniCV.tex

echo "[3/4] Checking for PDF..."
if [ ! -f "LugariniCV.pdf" ]; then
    echo "ERROR: LugariniCV.pdf was not created."
    exit 1
fi

echo "[4/4] Generating PNGs..."
# Create directory if it doesn't exist (mkdir -p)
mkdir -p assets

echo "Cleaning old PNGs..."
# Remove old files silently (rm -f)
rm -f assets/LugariniCV-*.png

echo "Converting PDF to PNGs..."
# Check if pdftoppm is installed
if ! command -v pdftoppm &> /dev/null; then
    echo "Error: pdftoppm is not installed. Run 'brew install poppler' to install it."
    exit 1
fi

pdftoppm -png LugariniCV.pdf assets/LugariniCV

echo "Done! PNG files are in the 'assets' folder."