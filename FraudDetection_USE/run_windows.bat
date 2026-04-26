@echo off
:: ============================================================
::  FraudDetection USE Launcher — Windows
::  Place this file next to the USE tool folder
:: ============================================================

echo ========================================
echo  FraudDetection OCL Checker
echo  USE Tool Launcher
echo ========================================
echo.

:: Check Java
java -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java not found! Install Java from https://adoptium.net/
    pause
    exit /b 1
)

:: Find use.jar — adjust path if needed
set USE_JAR=use.jar
if not exist %USE_JAR% (
    echo [ERROR] use.jar not found in this folder.
    echo Place this script next to use.jar from the USE tool.
    pause
    exit /b 1
)

echo [1] GUI Mode (recommended)
echo [2] Command-line mode (headless check)
echo.
set /p choice=Choose mode (1 or 2): 

if "%choice%"=="1" (
    echo Starting USE GUI...
    java -jar %USE_JAR% -gui model\FraudDetection.use
) else (
    echo Running headless constraint check...
    java -jar %USE_JAR% -nogui model\FraudDetection.use soil\instances.soil
    pause
)
