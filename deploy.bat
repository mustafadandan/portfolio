@echo off
:: Ensure the script runs from the directory it is placed in
cd /d "%~dp0"

echo =======================================
echo 🚀 STARTING PORTFOLIO DEPLOYMENT SCRIPT
echo =======================================

echo.
echo 1. Staging all changes...
git add --all

echo.
echo 2. Committing changes...
:: This grabs the current date and time for an automated commit message
git commit -m "Automated update: %date% %time%"

echo.
echo 3. Pushing source code to GitHub...
git push

echo.
echo 4. Deploying compiled site to GitHub Pages...
call npx ng deploy --base-href=/MustafaDandan/


echo.
echo =======================================
echo 🎉 DEPLOYMENT COMPLETE!
echo =======================================
echo.
pause

