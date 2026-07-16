# FLASHPOINT - Automated Security Response Platform

**Automated Security Response in Action**

A highly customized, fully automated incident simulation tool demonstrating modern security automation workflows across 6 real-world use cases.

## Overview

FLASHPOINT demonstrates six automated security response use cases:

### Original Use Cases
- **Use Case #1**: Supply Chain Threat - Automated CVE detection and patching via Lightwell
- **Use Case #2**: Compliance & Media Pressure - SBOM generation and regulatory response
- **Use Case #3**: Infrastructure Audit - Ansible Automation Platform server patching

### New Security & Compliance Use Cases
- **Use Case #4**: Secret Sprawl Detection - Automated HashiCorp Vault secret rotation and remediation
- **Use Case #5**: Certificate Expiration Crisis - Automated Let's Encrypt ACME certificate renewal
- **Use Case #6**: Cloud Misconfiguration Remediation - Automated AWS CSPM detection and S3 bucket security fixes

## Features

- Real-time metrics dashboard (System Stability, Regulatory Risk, Reputational Risk)
- Visual pipeline timelines showing automation progress
- Live SIEM logs with color-coded severity
- Comparison mode showing automated vs manual response times
- Remote control via API for "magic" demonstrations

## Remote Control API

The simulation can be controlled remotely via curl commands, perfect for running demonstrations from another terminal while the browser is projected.

### Base URL
```
http://localhost/war-game/api.php
```

Replace `localhost` with your server hostname/IP as needed.

---

## Use Case Controls

### Trigger Use Case #1: Supply Chain Threat
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:1"
```
Triggers CVE-2026-1234 detection in lib-crypto-core package, initiating automated Lightwell remediation.

### Trigger Use Case #2: Compliance & Media Pressure
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:2"
```
Triggers compliance auditor and media inquiry, generating cryptographically-signed SBOM.

### Trigger Use Case #3: Infrastructure Audit
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:3"
```
Initiates Ansible audit of 25 RHEL servers for access controls and vulnerabilities.

### Trigger Use Case #4: Secret Sprawl Detection
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:4"
```
Detects hardcoded secrets across codebase and triggers automated HashiCorp Vault rotation.

### Trigger Use Case #5: Certificate Expiration Crisis
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:5"
```
Discovers expiring SSL certificates and automates Let's Encrypt ACME renewal workflow.

### Trigger Use Case #6: Cloud Misconfiguration Remediation
```bash
curl -X POST http://localhost/war-game/api.php -d "command=trigger:6"
```
Detects publicly exposed S3 buckets via AWS CSPM and automatically remediates security issues.

---

## Simulation Controls

### Start Simulation
```bash
curl -X POST http://localhost/war-game/api.php -d "command=start"
```

### Pause Simulation
```bash
curl -X POST http://localhost/war-game/api.php -d "command=pause"
```

### Reset All
```bash
curl -X POST http://localhost/war-game/api.php -d "command=reset"
```
Resets the simulation to initial state, clearing all metrics and logs.

---

## Action Button Controls

These commands click the interactive buttons that appear during workflows.

### Start CI/CD Pipeline
```bash
curl -X POST http://localhost/war-game/api.php -d "command=cicd"
```
Clicks the "🚀 Start CI/CD pipeline" button (when visible after Use Case #1 automated checks complete).

### Check Lightwell for Remediation
```bash
curl -X POST http://localhost/war-game/api.php -d "command=remediation"
```
Clicks the "🔍 Check Lightwell for remediation options" button (when visible after Use Case #2 SBOM shows vulnerable).

### Use Ansible to Patch Servers
```bash
curl -X POST http://localhost/war-game/api.php -d "command=ansible"
```
Clicks the "🤖 Use Ansible to Patch Servers" button (when visible after Use Case #3 finds vulnerable servers).

### Toggle Comparison Mode
```bash
curl -X POST http://localhost/war-game/api.php -d "command=comparison"
```
Shows/hides the automated vs manual response time comparison panel.

---

## Utility Commands

### Check Pending Command
```bash
curl http://localhost/war-game/api.php
```
Returns any pending command in the queue.

### Clear Command Queue
```bash
curl -X DELETE http://localhost/war-game/api.php
```
Clears any pending commands.

---

## Quick Demo Scripts

### Full Use Case #1 Demo
Demonstrates end-to-end automated application patching workflow.

```bash
#!/bin/bash
# Start and run Use Case #1 with CI/CD deployment

curl -X POST http://localhost/war-game/api.php -d "command=start"
sleep 1

curl -X POST http://localhost/war-game/api.php -d "command=trigger:1"
echo "Triggered Use Case #1 - waiting for automated checks..."
sleep 8

curl -X POST http://localhost/war-game/api.php -d "command=cicd"
echo "Started CI/CD pipeline - deployment in progress..."
```

### Full Use Case #3 Demo
Demonstrates infrastructure audit and Ansible automated patching.

```bash
#!/bin/bash
# Start and run Use Case #3 with Ansible patching

curl -X POST http://localhost/war-game/api.php -d "command=start"
sleep 1

curl -X POST http://localhost/war-game/api.php -d "command=trigger:3"
echo "Triggered Use Case #3 - Ansible audit running..."
sleep 12

curl -X POST http://localhost/war-game/api.php -d "command=ansible"
echo "Ansible patching 7 servers - please wait..."
```

### Complete Walkthrough
Shows all three use cases in sequence.

```bash
#!/bin/bash
# Comprehensive demo of all use cases

echo "Starting Crisis Simulator Demo..."
curl -X POST http://localhost/war-game/api.php -d "command=start"
sleep 2

echo ""
echo "=== USE CASE #1: Supply Chain Threat ==="
curl -X POST http://localhost/war-game/api.php -d "command=trigger:1"
sleep 8
curl -X POST http://localhost/war-game/api.php -d "command=cicd"
sleep 15

echo ""
echo "Resetting for next use case..."
curl -X POST http://localhost/war-game/api.php -d "command=reset"
sleep 3
curl -X POST http://localhost/war-game/api.php -d "command=start"
sleep 2

echo ""
echo "=== USE CASE #3: Infrastructure Audit ==="
curl -X POST http://localhost/war-game/api.php -d "command=trigger:3"
sleep 12
curl -X POST http://localhost/war-game/api.php -d "command=ansible"
sleep 15

echo ""
echo "Demo complete!"
curl -X POST http://localhost/war-game/api.php -d "command=comparison"
echo "Comparison mode enabled - showing automated vs manual timings"
```

---

## Browser-Based Remote Control

For non-command-line control, open `http://localhost/war-game/trigger.html` in a separate browser tab/window for a GUI control panel.

---

## How It Works

1. **Send Command**: curl POST sends command to `api.php`
2. **Command Storage**: API writes command to `/tmp/war-game-command.txt` with timestamp
3. **Polling**: Main simulation polls API every 500ms
4. **Execution**: When command found, simulation executes it and clears the file
5. **Auto-Expire**: Commands older than 10 seconds are automatically discarded

---

## Tips for Demonstrations

### "Magic" Demonstrations
Run curl commands from an SSH session while projecting the browser. The simulation will appear to respond "automatically" to events!

### Custom Timing
Adjust `sleep` values in scripts to match your presentation pace.

### Multiple Screens
- Screen 1: Projected browser showing simulation
- Screen 2: Terminal running curl commands
- Screen 3: (Optional) trigger.html control panel

### Keyboard Shortcuts
For even faster control, create shell aliases:

```bash
# Add to ~/.bashrc or ~/.zshrc
alias wg-reset='curl -X POST http://localhost/war-game/api.php -d "command=reset"'
alias wg-start='curl -X POST http://localhost/war-game/api.php -d "command=start"'
alias wg-uc1='curl -X POST http://localhost/war-game/api.php -d "command=trigger:1"'
alias wg-uc2='curl -X POST http://localhost/war-game/api.php -d "command=trigger:2"'
alias wg-uc3='curl -X POST http://localhost/war-game/api.php -d "command=trigger:3"'
alias wg-uc4='curl -X POST http://localhost/war-game/api.php -d "command=trigger:4"'
alias wg-uc5='curl -X POST http://localhost/war-game/api.php -d "command=trigger:5"'
alias wg-uc6='curl -X POST http://localhost/war-game/api.php -d "command=trigger:6"'
alias wg-cicd='curl -X POST http://localhost/war-game/api.php -d "command=cicd"'
alias wg-ansible='curl -X POST http://localhost/war-game/api.php -d "command=ansible"'
```

Then simply type `wg-uc1` instead of the full curl command!

---

## Files

- `index.html` - Main simulation interface
- `api.php` - Remote control API endpoint
- `trigger.html` - Browser-based control panel
- `workflow` - Workflow documentation
- `README.md` - This file

---

## Technical Details

### System Requirements
- Web server with PHP support (Apache/Nginx)
- Modern browser (Chrome, Firefox, Safari, Edge)
- `/tmp` directory with write permissions (for API)

### Browser Compatibility
- Chrome/Edge: Full support
- Firefox: Full support
- Safari: Full support
- Mobile browsers: Layout optimized but best viewed on desktop

### Security Notes
- API accepts commands from any origin (CORS enabled)
- No authentication required (intended for internal demos)
- For production use, implement authentication and restrict CORS

---

---

## 🐳 Container Deployment

### Quick Start with Podman

Build and run FLASHPOINT in a container using Podman:

```bash
# Build the container image
podman build -t flashpoint:2.0.0 .

# Run the container
podman run -d \
  --name flashpoint \
  -p 8080:8080 \
  flashpoint:2.0.0

# Access FLASHPOINT
# Open browser to: http://localhost:8080
```

### Podman Commands

**View logs:**
```bash
podman logs -f flashpoint
```

**Stop container:**
```bash
podman stop flashpoint
```

**Remove container:**
```bash
podman rm flashpoint
```

**Restart container:**
```bash
podman restart flashpoint
```

**Check container health:**
```bash
podman healthcheck run flashpoint
```

### Running on Different Port

```bash
podman run -d \
  --name flashpoint \
  -p 9090:8080 \
  flashpoint:2.0.0

# Access at: http://localhost:9090
```

### Rootless Deployment

Podman supports rootless containers by default. No sudo required!

```bash
# Build as regular user
podman build -t flashpoint:2.0.0 .

# Run as regular user
podman run -d --name flashpoint -p 8080:8080 flashpoint:2.0.0
```

### Production Deployment

For production environments with persistent data and custom configuration:

```bash
podman run -d \
  --name flashpoint-prod \
  -p 8080:8080 \
  --restart=always \
  --health-cmd='curl -f http://localhost:8080/ || exit 1' \
  --health-interval=30s \
  flashpoint:2.0.0
```

### Remote Control API in Container

When running in a container, adjust the API endpoint:

```bash
# From host machine
curl -X POST http://localhost:8080/api.php -d "command=trigger:1"

# From container network
curl -X POST http://flashpoint:8080/api.php -d "command=trigger:1"
```

### Using with Podman Compose

Create a `compose.yml`:

```yaml
version: '3'
services:
  flashpoint:
    build: .
    container_name: flashpoint
    ports:
      - "8080:8080"
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/"]
      interval: 30s
      timeout: 3s
      retries: 3
```

Run with:
```bash
podman-compose up -d
```

### Container Registry

Push to your registry for easy deployment:

```bash
# Tag for registry
podman tag flashpoint:2.0.0 registry.example.com/flashpoint:2.0.0

# Push to registry
podman push registry.example.com/flashpoint:2.0.0

# Pull and run on another host
podman pull registry.example.com/flashpoint:2.0.0
podman run -d -p 8080:8080 registry.example.com/flashpoint:2.0.0
```

### SELinux Considerations (RHEL/Fedora)

If you encounter SELinux permission issues:

```bash
# Option 1: Add SELinux label to container
podman run -d \
  --name flashpoint \
  --security-opt label=type:container_runtime_t \
  -p 8080:8080 \
  flashpoint:2.0.0

# Option 2: Temporarily permissive (testing only)
sudo setenforce 0

# Restore enforcing mode
sudo setenforce 1
```

### Firewall Configuration

Open port on RHEL/Fedora:

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

### Troubleshooting

**Container won't start:**
```bash
# Check logs
podman logs flashpoint

# Inspect container
podman inspect flashpoint
```

**Port already in use:**
```bash
# Find what's using port 8080
sudo lsof -i :8080

# Use different port
podman run -d -p 9090:8080 flashpoint:2.0.0
```

**Permission denied on /tmp:**
```bash
# Run with privileged mode (testing only)
podman run -d --privileged -p 8080:8080 flashpoint:2.0.0
```

---

## Version
FLASHPOINT v2.0.0

---

## Credits
Created with Gemini and enhanced with Claude magic ✨
