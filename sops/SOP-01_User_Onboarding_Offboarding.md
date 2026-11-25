# SOP-01: Employee IT Onboarding & Offboarding Procedure

**Document ID:** IT-SOP-001  
**Scope:** Windows/macOS Workstations, Microsoft 365, Microsoft Entra ID, Network Printers  

---

## 1. Employee Onboarding Workflow
1. **Identity & License Provisioning (Entra ID & Microsoft 365):**
   * Create user account in **Microsoft Entra admin center** using standard naming convention (`firstname.lastname@domain.com`).
   * Assign required **Microsoft 365** license (Exchange Online, Teams, Office Apps) and add user to department Security Groups (`Finance_Advisory`, `Operations`, etc.).
   * Enforce **Multi-Factor Authentication (MFA)** and set temporary password requiring change at first login.
2. **Workstation Preparation (Windows / macOS):**
   * Verify OS updates, endpoint antivirus agent (Windows Defender / EDR), and disk encryption (**BitLocker** on Windows; **FileVault** on macOS) are active.
   * Configure corporate Wi-Fi profile, VPN client, and map network printers.
   * Record hardware Serial Number and Asset ID in `IT_Asset_and_License_Register.csv`.
3. **Handover & Verification:**
   * Conduct a 10-minute orientation confirming email login, MFA prompt, shared drive access, and IT helpdesk ticket submission steps.

## 2. Employee Offboarding Workflow (Security-Critical)
1. **Immediate Access Revocation:**
   * Disable user sign-in in **Microsoft Entra ID** and revoke all active refresh tokens/sessions.
   * Reset account password and remove user from all Security Groups and distribution lists.
2. **Data & Mailbox Retention:**
   * Convert the departing user's Exchange mailbox to a **Shared Mailbox** and grant read access to their reporting manager if approved by HR.
   * Transfer OneDrive ownership to the manager for business continuity.
3. **Hardware Retrieval & Inventory Update:**
   * Collect laptop, charger, access badges, and mobile devices.
   * Inspect hardware condition, wipe/re-image workstation before redeployment, and update asset status to `In Stock - Ready` in the IT Asset Register.
