# NOC Incident Ticket Resolution Lab

A fictional, hands-on NOC portfolio project demonstrating an incident workflow using Ubuntu Linux, Apache, Bash, and Git.

> **Lab notice:** All incidents and impact statements in this repository are simulated. Do not represent them as production incidents or claim results you have not personally observed.

## Scenario: INC-1001 — Web Server Unavailable

A simulated monitoring alert reports that an internal website is unavailable. The analyst must establish scope, check connectivity and the listening port, inspect Apache status and logs, restore the service when appropriate, verify recovery, and document the ticket.

## Skills demonstrated
- Incident triage, prioritization, and documentation
- Linux service troubleshooting with `systemctl`
- Network and port checks with `ping`, `getent`, `ss`, and `nc`
- HTTP validation with `curl`
- Log review with `journalctl`
- Bash scripting and Git version control
- Escalation based on impact, evidence, and permissions

## Lab requirements
- Ubuntu 24.04 or compatible Linux VM
- Apache2
- `curl`, `dnsutils`, and `netcat-openbsd`
- Git (for version control)

Install dependencies:
```bash
sudo apt update
sudo apt install apache2 curl dnsutils netcat-openbsd git -y
sudo systemctl enable --now apache2
```

## Run the health check
From this repository directory:
```bash
chmod +x scripts/health_check.sh
./scripts/health_check.sh
```

The script checks root filesystem usage, Apache service status, whether port 80 is listening, and whether a local HTTP request succeeds. It reports results but does not automatically restart services.

## Incident simulation
**Only run the stop/start steps in your own lab VM.** Do not run them on a production or shared server.

1. Establish a baseline:
   ```bash
   systemctl is-active apache2
   sudo ss -lntp | grep ':80'
   curl -I --max-time 5 http://localhost
   ```
2. Simulate an outage:
   ```bash
   sudo systemctl stop apache2
   ```
3. Collect evidence before remediation:
   ```bash
   systemctl is-active apache2
   nc -zv 127.0.0.1 80
   curl -I --max-time 5 http://localhost
   sudo journalctl -u apache2 -n 30 --no-pager
   ```
4. Restore service:
   ```bash
   sudo systemctl start apache2
   ```
5. Verify recovery:
   ```bash
   systemctl is-active apache2
   sudo ss -lntp | grep ':80'
   curl -I --max-time 5 http://localhost
   ```
6. Complete `tickets/INC-1001.md` using your actual results and timestamps.

Expected behavior may vary by environment. A failed port check does not, by itself, identify the root cause. Use multiple sources of evidence.

## Repository contents
- `scripts/health_check.sh` — repeatable local health checks
- `tickets/INC-1001.md` — incident ticket template and example scenario
- `docs/troubleshooting-checklist.md` — investigation checklist
- `docs/escalation-template.md` — escalation handoff template

## Portfolio evidence
Add screenshots only after running the lab yourself. Recommended evidence:
1. Baseline health check
2. Failed check during the simulated outage
3. Relevant service logs
4. Successful checks after recovery

Never include passwords, tokens, public IPs you do not intend to share, or sensitive system information.

## Resume bullet (use after completing the lab)
Built a Linux NOC incident-response lab using Bash and Apache; simulated a web-service outage, validated service and port availability, reviewed system logs, restored service, and documented verification steps.
