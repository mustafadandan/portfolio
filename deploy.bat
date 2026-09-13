@echo off
:: Force the script to run from the directory where this file lives
cd /d "%~dp0"

echo =======================================================
echo 🚀 RUNNING AUTO-ROUTING ANGULAR DEPLOYMENT
echo =======================================================

echo.
echo 📦 1. Wiping out local build caches...
if exist dist rmdir /s /q dist
if exist .angular rmdir /s /q .angular

echo.
echo 🧹 2. Staging and syncing source code to main...
git rm -r --cached dist/ >nul 2>&1
git add --all
git commit -m "Automated layout build: %date% %time%"
git push origin main

echo.
echo ⚙️ 3. Compiling production bundle with explicit base path...
call npx ng build --configuration production --base-href=/portfolio/

echo.
echo 🚀 4. Preparing static deployment repository...
:: Navigate directly into the generated browser assets folder
cd dist\portfolio\browser

:: Initialize a fresh temporary repository to handle the overwrite cleanly
git init >nul 2>&1
git checkout -b gh-pages >nul 2>&1
git remote add origin https://github.com >nul 2>&1

echo.
echo ⬆️ 5. Force-pushing new deployment tracking to GitHub Pages...
git add --all
git commit -m "Forced production deployment via automation script" >nul 2>&1
git push -f origin gh-pages

echo.
echo =======================================================
echo 🎉 DEPLOYMENT SEQUENCE COMPLETE! YOUR SITE IS UPDATING!
echo =======================================================
echo.
pause
