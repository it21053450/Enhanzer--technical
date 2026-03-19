@echo off
cls
title EnhanzerFrontend - Running on http://localhost:4200
cd /d "C:\Users\odith\OneDrive\Desktop\Assignment\EnhanzerFrontend"
echo ========================================
echo Starting EnhanzerFrontend
echo ========================================
echo Frontend Port: http://localhost:4200
echo.
echo First time? Installing dependencies...
echo.
call npm install
echo.
echo ========================================
echo Starting Development Server
echo ========================================
echo Open browser: http://localhost:4200
echo.
call npm start
