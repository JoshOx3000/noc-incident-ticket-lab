Steps Taken

1.Run health_check.sh  and the results:
<img width="814" height="402" alt="Screenshot 2026-10-27 at 10 31 07 AM" src="https://github.com/user-attachments/assets/e68fadcc-e289-47dc-8185-45f895bcc108" />


2. Results "Failed to connect to localhost port 80 and HTTP connection failed. Before changing anything investigate, I investigate the server and network
   Ran this command in the linux terminal

hostname
ip addr
ip route
ping -c 4 127.0.0.1

3. Check DNS - user command in terminal below
getent hosts localhost

getent hosts was a useful diagnostic, but DNS was not the cause of this incident. DNS resolution was checked as part of the broader investigation.

5. Check whether the web server service is running, used command "sudo systemctl status apache2 --no-pager"
<img width="940" height="482" alt="Screenshot 2026-10-27 at 10 43 20 AM" src="https://github.com/user-attachments/assets/9c88ee13-7ad9-4fc1-be6a-3a83628ad5bc" />

results: inactive (dead) — the service is stopped.

5. Test the website locally, curl -I --max-time 5 http://127.0.0.1
<img width="940" height="48" alt="Screenshot 2026-10-27 at 10 56 23 AM" src="https://github.com/user-attachments/assets/d8338608-2529-47d5-bb3a-eeedebcf42f7" />

results: Failed to connect, An HTTP response other than 200 does not automatically mean the web server is unavailable.

6. Check logs sudo journalctl -u apache2 -n 50 --no-pager
<img width="1204" height="687" alt="Screenshot 2026-10-27 at 11 03 04 AM" src="https://github.com/user-attachments/assets/dff3142f-cc00-4174-a5b5-458a0a716a78" />

<img width="1212" height="236" alt="Screenshot 2026-10-27 at 11 03 22 AM" src="https://github.com/user-attachments/assets/a369ac2b-1a0e-4a82-b5a8-5ca7ffd46c3e" />

7. Check server services
 df -h
results:
<img width="561" height="153" alt="Screenshot 2026-10-27 at 11 12 43 AM" src="https://github.com/user-attachments/assets/b9c49973-2a52-4174-bf3d-94497b9e33f8" />

free -h
results:
<img width="826" height="94" alt="Screenshot 2026-10-27 at 11 12 51 AM" src="https://github.com/user-attachments/assets/08e3f5fb-45cb-4177-8be5-f8b8fe0371c8" />

uptime
results:
<img width="736" height="59" alt="Screenshot 2026-10-27 at 11 12 57 AM" src="https://github.com/user-attachments/assets/8460c716-11f6-43c0-a825-2f9f044a0fce" />

8. Identify the issue, apache2 service has been stop

9. Resolve the issue by starting apache2 service, sudo systemctl start apache2
<img width="517" height="45" alt="Screenshot 2026-10-27 at 11 19 57 AM" src="https://github.com/user-attachments/assets/e56be02a-862a-495c-b04b-fb220554777f" />

10. Verify Service is active, sudo systemctl is-active apache2
<img width="529" height="45" alt="Screenshot 2026-10-27 at 11 26 26 AM" src="https://github.com/user-attachments/assets/195cf062-d0f8-42bf-91df-820a1047a718" />

11. Run some additional check to verify apache2 is back up and running

sudo systemctl status apache2 --no-pager
<img width="1192" height="418" alt="Screenshot 2026-10-27 at 11 28 47 AM" src="https://github.com/user-attachments/assets/7ad99576-c5bf-443c-852a-7a04f90bd62d" />

curl -I --max-time 5 http://127.0.0.1
<img width="589" height="227" alt="Screenshot 2026-10-27 at 11 30 23 AM" src="https://github.com/user-attachments/assets/50ff94b5-89b0-4d3a-af41-c467d7f6473d" />

Result: HTTP/1.1 200 OK — the server returned a successful HTTP response.

12. 

<img width="612" height="401" alt="Screenshot 2026-10-27 at 11 40 23 AM" src="https://github.com/user-attachments/assets/138a9432-afc9-466f-9205-abbcc6e67fba" />

13. Run Check health script to verify apache2 is back up and running
<img width="612" height="401" alt="Screenshot 2026-10-27 at 11 40 23 AM" src="https://github.com/user-attachments/assets/f100e921-0ded-4582-9087-153175d6c2cf" />


  Resolution:
  INC-1001 — Web Server Unavailable
- Detection: Health-check script reported the web service was unavailable.
- Investigation: Checked service status, port 80, HTTP response, and Apache logs.
- Evidence: Recorded actual command outputs and timestamps.
- Root cause: Apache was deliberately stopped for the lab simulation.
- Remediation: Started Apache using systemctl.
- Verification: Confirmed service status, listening port, and HTTP response.
- Final status: Resolved after successful verification.
