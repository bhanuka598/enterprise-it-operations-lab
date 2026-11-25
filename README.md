# Enterprise IT Operations & Security Support Suite

A practical IT support, infrastructure diagnostics, asset governance, and security operations portfolio demonstrating first-level enterprise helpdesk workflows across Windows, macOS, Microsoft 365/Entra ID, and TCP/IP networks.

## Key Capabilities Demonstrated
* **Automated Workstation & Network Diagnostics (`scripts/Invoke-ITSupportToolkit.ps1`):** PowerShell toolkit that audits OS health, disk capacity, Print Spooler status, Windows Defender endpoint protection, IPv4/Gateway/DNS routing, and generates timestamped support logs.
* **User Lifecycle & Access Management (`sops/SOP-01_User_Onboarding_Offboarding.md`):** Standard Operating Procedure covering Windows/macOS workstation setup, Microsoft 365 license assignment, Entra ID group permissions, MFA enforcement, and secure employee offboarding.
* **Information Security & Phishing Triage (`sops/SOP-02_Phishing_and_Security_Incident_Response.md`):** Incident response workflow covering email header verification (SPF, DKIM, DMARC), endpoint antivirus validation, and user phishing escalation.
* **IT Asset Governance & ITSM Ticketing (`registers/`):** Structured hardware asset inventory, software license seat tracker, and categorized ITSM incident/service request resolution logs.
* **Network & Firewall Root-Cause Analysis (`lab-reports/Network_and_Firewall_Troubleshooting_Report.md`):** Step-by-step break-fix lab documenting layered ping isolation (`127.0.0.1` -> Gateway -> `8.8.8.8` -> DNS), DNS cache recovery, and Windows Defender Firewall rule testing.

## How to Run the Diagnostic Script (Windows)
1. Open **PowerShell** in the `scripts/` directory.
2. Execute:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\Invoke-ITSupportToolkit.ps1
   ```
3. Select an option from the interactive menu to generate a real diagnostic report inside `lab-reports/`.
