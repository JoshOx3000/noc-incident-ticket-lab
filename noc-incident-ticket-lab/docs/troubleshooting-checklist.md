# NOC Web-Service Troubleshooting Checklist

Use this checklist in order and record results in the incident ticket.

## 1. Alert triage
- [ ] Confirm alert time, host, service, and monitoring source.
- [ ] Determine whether one host or multiple hosts are affected.
- [ ] Identify business impact and follow the organization's priority matrix.
- [ ] Check for recent changes or related incidents.

## 2. Connectivity and name resolution
- [ ] Confirm the correct hostname and IP address.
- [ ] `ping -c 4 <host>` where ICMP is allowed; lack of ping response alone does not prove the host is down.
- [ ] `getent hosts <hostname>` or `nslookup <hostname>` to investigate name resolution.
- [ ] Test the relevant TCP port, for example `nc -zv <host> 80` or `nc -zv <host> 443`.

## 3. Service and application
- [ ] `systemctl status apache2 --no-pager`
- [ ] `sudo ss -lntp` to inspect listening sockets.
- [ ] `curl -I --max-time 5 http://localhost` for local HTTP validation.
- [ ] For HTTPS, verify that TLS/443 is configured before testing it.

## 4. Host resources and logs
- [ ] `df -h` for filesystem capacity.
- [ ] `free -h` for memory.
- [ ] `top` for process/resource activity; press `q` to exit.
- [ ] `sudo journalctl -u apache2 -n 50 --no-pager`
- [ ] Check relevant system logs and timestamps.

## 5. Remediation and escalation
- [ ] Follow approved runbooks and permissions.
- [ ] Capture evidence before making changes.
- [ ] Escalate if impact is broad, the cause is unclear, or action is outside your authorization.
- [ ] Share impact, timeline, checks, results, and actions with the receiving team.

## 6. Verify and close
- [ ] Confirm service status, listening port, and application response.
- [ ] Confirm alert/monitoring recovery when monitoring is available.
- [ ] Record root cause only when supported by evidence.
- [ ] Document resolution, timestamps, communications, and follow-up.
