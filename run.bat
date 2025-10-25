@echo off
echo [1/4] Compiling LaTeX (Pass 1)...
pdflatex -interaction=nonstopmode LugariniCV.tex

echo [2/4] Compiling LaTeX (Pass 2)...
pdflatex -interaction=nonstopmode LugariniCV.tex

echo [3/4] Checking for PDF...
if not exist LugariniCV.pdf (
    echo ERROR: LugariniCV.pdf was not created.
    goto :eof
)

echo [4/4] Generating PNGs...
if not exist assets mkdir assets

echo Cleaning old PNGs...
del /Q assets\LugariniCV-*.png 2>nul

echo Converting PDF to PNGs...
pdftoppm -png LugariniCV.pdf assets/LugariniCV

echo Done! PNG files are in the 'assets' folder.