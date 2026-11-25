# Lab Report: Network Diagnostics & Windows Firewall Rule Testing

**Analyst:** [Your Name]  
**Environment:** Windows 11 Workstation / Virtual Lab  

---

## 1. Layered Network Troubleshooting Methodology
When diagnosing connectivity issues, tests are executed from Layer 1/Local Host outward to isolate the exact point of failure:
1. **Loopback (`ping 127.0.0.1`):** Verifies local TCP/IP stack and network adapter driver health.
2. **Default Gateway (`ping <Gateway_IP>`):** Verifies local LAN/Wi-Fi link to the switch and router.
3. **External IPv4 (`ping 8.8.8.8`):** Verifies WAN/ISP internet routing without relying on DNS.
4. **Domain Name Resolution (`nslookup sampathwealth.com`):** Verifies DNS server reachability and name-to-IP translation.

## 2. Simulated DNS Outage & Recovery Drill
* **Fault Injected:** Configured workstation IPv4 DNS server manually to `192.0.2.1` (non-routable test address).
* **Observed Symptom:** `ping 8.8.8.8` succeeded (0% packet loss), confirming internet access was intact, while web browsers and `nslookup` timed out.
* **Remediation:** Reverted IPv4 properties to obtain DNS automatically via DHCP and executed `ipconfig /flushdns`. Name resolution was restored immediately.

## 3. Windows Defender Firewall Outbound Rule Validation
* **Objective:** Verify host-level traffic filtering using `wf.msc` (Windows Defender Firewall with Advanced Security).
* **Test Executed:** Created a custom Outbound Rule blocking ICMPv4 Echo Requests (`ping`). Confirmed `ping 8.8.8.8` returned `General failure` while the rule was active, then removed the test rule to restore baseline ICMP diagnostics.
