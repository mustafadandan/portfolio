@echo off
:: Force the script to run from the directory where this file lives
cd /d "%~dp0"

echo =======================================================
echo 🚀 RUNNING SECURE ANGULAR 19 DEPLOYMENT TO GITHUB PAGES
echo =======================================================

echo.
echo 📦 1. Wiping out local build caches...
if exist dist rmdir /s /q dist
if exist .angular rmdir /s /q .angular

echo.
echo 🧹 2. Resetting Git file tracking...
:: Ensure Git stops tracking built assets if they were accidentally added
git rm -r --cached dist/ >nul 2>&1
git add --all

echo.
echo 💾 3. Creating automated tracking commit...
git commit -m "Automated layout build: %date% %time%"

echo.
echo ⬆️ 4. Pushing development source code to main branch...
git push origin main

echo.
echo ⚙️ 5. Compiling production bundle with explicit base path...
:: This explicitly overrides any old internal configuration with your repository name
call npx ng build --configuration production --base-href=/portfolio/

echo.
echo 🚀 6. Force-deploying static assets to gh-pages...
:: Directs the gh-pages tool straight to the Angular 19 browser target folder
call npx angular-cli-ghpages --dir=dist/portfolio/browser --no-silent

echo.
echo =======================================================
echo 🎉 DEPLOYMENT SEQUENCE COMPLETE!
echo =======================================================
echo.
pause
