# SOP-02: Phishing Triage & Security Incident Escalation

**Document ID:** IT-SOP-002  
**Scope:** Email Security, Endpoint Protection, End-User Phishing Reports  

---

## 1. End-User Reporting Guidelines
* Staff must **not** click links, download attachments, or reply to suspicious emails.
* Staff must report suspicious messages immediately using the **Report Phishing** button or by forwarding the email as an attachment (`.eml`/`.msg`) to the IT Helpdesk.

## 2. First-Level IT Triage Checklist
1. **Inspect Sender & Reply-To Headers:**
   * Open message headers (`Show Original` / `Message Properties`) and verify whether the `From` display address matches the actual `Return-Path` domain (check for lookalike/typosquatted domains).
2. **Verify Email Authentication Records:**
   * Inspect the `Authentication-Results` header for three controls:
     * **SPF (Sender Policy Framework):** Confirms sending mail server IP is authorized.
     * **DKIM (DomainKeys Identified Mail):** Confirms cryptographic signature integrity.
     * **DMARC:** Confirms domain alignment and enforcement policy.
3. **Analyze URLs & Attachments Safely:**
   * Hover over or extract links without opening them in a standard browser; inspect destination domains using a reputable threat-intelligence sandbox.
4. **Containment & Remediation:**
   * If confirmed malicious, block the sender domain/IP in the email security gateway and purge the message from affected mailboxes.
   * If a user clicked a link or entered credentials: immediately reset their **Entra ID** password, revoke active sessions, verify MFA methods for unauthorized additions, and run a full endpoint antivirus scan.
5. **Escalation & Documentation:**
   * Log all indicators of compromise (sender address, subject, URLs, affected users) in the ITSM ticket and escalate confirmed breaches to Senior IT / Information Security management.
