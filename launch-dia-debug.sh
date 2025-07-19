#!/bin/bash

# Launch Dia Browser with Chrome DevTools Protocol enabled
# This script helps users easily start Dia Browser with the correct flags

echo "🚀 Launching Dia Browser with remote debugging enabled..."
echo "📡 Chrome DevTools Protocol will be available on port 9222"
echo ""

# Check if Dia Browser exists
if [ ! -f "/Applications/Dia.app/Contents/MacOS/Dia" ]; then
    echo "❌ Error: Dia Browser not found at /Applications/Dia.app"
    echo "Please make sure Dia Browser is installed."
    exit 1
fi

# Check if port 9222 is already in use
if lsof -Pi :9222 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  Warning: Port 9222 is already in use."
    echo "Another instance of Dia Browser or Chrome might be running with remote debugging."
    echo ""
    echo "To fix this:"
    echo "1. Close all browser instances"
    echo "2. Run this script again"
    echo ""
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "🌐 Starting Dia Browser..."
echo "💡 You can now use the Dia Browser Control MCP extension"
echo ""
echo "To test the connection, run: node test-cdp.js"
echo "To stop, press Ctrl+C in this terminal"
echo ""

# Launch Dia Browser with remote debugging
exec /Applications/Dia.app/Contents/MacOS/Dia --remote-debugging-port=9222
