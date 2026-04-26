#!/bin/bash
# ============================================================
#  FraudDetection USE Launcher — Linux / macOS
# ============================================================

echo "========================================"
echo " FraudDetection OCL Checker"
echo " USE Tool Launcher"
echo "========================================"
echo

# Check Java
if ! command -v java &> /dev/null; then
    echo "[ERROR] Java not found! Install Java from https://adoptium.net/"
    exit 1
fi

# Find use.jar
USE_JAR="use.jar"
if [ ! -f "$USE_JAR" ]; then
    echo "[ERROR] use.jar not found in this folder."
    echo "Place this script next to use.jar from the USE tool."
    exit 1
fi

echo "1) GUI Mode (recommended)"
echo "2) Command-line mode (headless check)"
echo
read -p "Choose mode (1 or 2): " choice

if [ "$choice" == "1" ]; then
    echo "Starting USE GUI..."
    java -jar $USE_JAR -gui model/FraudDetection.use
else
    echo "Running headless constraint check..."
    java -jar $USE_JAR -nogui model/FraudDetection.use soil/instances.soil
fi
