# Dia Browser Control Extension

Control Dia Browser through Claude using Chrome DevTools Protocol.

## Features

- **Tab Management**: Open, close, switch between tabs
- **Navigation**: Navigate to URLs, go back/forward in history
- **Page Interaction**: Execute JavaScript, get page content
- **Browser Control**: Reload tabs, list all open tabs

## Available Tools

### `open_url`
Open a URL in Dia Browser, either in a new tab or current tab.

### `get_current_tab`
Get information about the currently active tab (URL, title, ID).

### `list_tabs`
List all open tabs across all Dia Browser windows.

### `close_tab`
Close a specific tab by its ID.

### `switch_to_tab`
Switch to a specific tab by its ID.

### `reload_tab`
Reload a tab (current tab or specific tab by ID).

### `go_back` / `go_forward`
Navigate through browser history.

### `execute_javascript`
Execute JavaScript code in a tab.

### `get_page_content`
Get the text content of a web page.

## Requirements

- macOS (arm64)
- Dia Browser installed (version 0.38.0 or later)
- Node.js (version 16.0.0 or later)

## Installation

To install this extension for Claude Desktop, download and open the `dia-browser-control.dxt` file.

## Setup

Before using this extension, you need to enable remote debugging in Dia Browser:

1. **Close Dia Browser completely** if it's running
2. **Launch Dia Browser with remote debugging enabled**:
   ```bash
   /Applications/Dia.app/Contents/MacOS/Dia --remote-debugging-port=9222
   ```
3. **Alternative**: Add the flag to your Dia Browser startup configuration

### Easy Startup Script

This repository includes a helper script to launch Dia Browser with the correct settings:

```bash
# Use the included script
./launch-dia-debug.sh
```

Or create your own script:

```bash
#!/bin/bash
# Save as ~/bin/dia-debug.sh and make executable
/Applications/Dia.app/Contents/MacOS/Dia --remote-debugging-port=9222
```

Then run: `chmod +x ~/bin/dia-debug.sh`

### Testing the Setup

After setting up remote debugging, you can test the connection:

```bash
# Test CDP connectivity
node test-cdp.js

# Or manually check the endpoint
curl http://localhost:9222/json
```

## Security

This extension requires access to control Dia Browser through Chrome DevTools Protocol. It can:
- Read and modify web page content
- Navigate to any URL
- Execute JavaScript in browser tabs
- Open, close, and switch between tabs
- Access information about open tabs (URL, title)

**Warning:** This extension provides powerful control over your browser. Only use it with trusted applications and be cautious about the commands you authorize. Since this tool can execute any JavaScript, it can potentially be used to perform malicious actions. Always review the scripts you are about to execute.

**Note:** Remote debugging must be enabled for this extension to work. This opens a debugging port (9222) on localhost, which should only be accessible from your local machine.

Use with appropriate caution and only grant access when necessary.

## Troubleshooting

### Common Issues

1. **"Dia Browser is not running with remote debugging enabled"**
   - Make sure Dia Browser is launched with `--remote-debugging-port=9222`
   - Check that no other application is using port 9222

2. **"Tab not found" errors**
   - The tab may have been closed or navigated away
   - Try refreshing the tab list with `list_tabs`

3. **JavaScript execution fails**
   - Check that the tab has finished loading
   - Verify the JavaScript syntax is correct
   - Some pages may have Content Security Policy restrictions

### Checking Remote Debugging

You can verify that remote debugging is working by visiting:
```
http://localhost:9222/json
```

This should show a JSON list of all open tabs.