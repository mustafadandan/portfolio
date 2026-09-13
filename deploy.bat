@echo off
:: Force the script to run from the directory where this file lives
cd /d "%~dp0"

echo =======================================================
echo 🚀 RUNNING FIXED ANGULAR 19 PRODUCTION DEPLOYMENT
echo =======================================================

echo.
echo 📦 1. Cleaning up old build caches...
if exist dist rmdir /s /q dist
if exist .angular rmdir /s /q .angular

echo.
echo 🧹 2. Saving development source code changes to main branch...
git rm -r --cached dist/ >nul 2>&1
git add --all
git commit -m "Automated build synchronization: %date% %time%"
git push origin main

echo.
echo ⚙️ 3. Compiling production bundle with absolute pathing inject...
:: This injects the exact, full URL path straight into your index.html base tag
call npx ng build --configuration production --base-href="https://github.io"

echo.
echo 🚀 4. Initializing static web deployment repo...
cd dist\portfolio\browser
git init >nul 2>&1
git checkout -b gh-pages >nul 2>&1
git remote add origin https://github.com >nul 2>&1

echo.
echo ⬆️ 5. Force-pushing production web assets to GitHub Pages...
git add --all
git commit -m "Forced production website deployment via deploy.bat" >nul 2>&1
git push -f origin gh-pages

echo.
echo =======================================================
echo 🎉 DEPLOYMENT COMPLETE! YOUR WEBSITE IS NOW ONLINE!
echo =======================================================
echo.
pause
