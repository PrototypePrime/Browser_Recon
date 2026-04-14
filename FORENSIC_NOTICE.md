# <img src="Icons/logo.png" width="40" height="40" valign="middle"> BrowserRecon: Forensic & Security Notice

![BrowserRecon Privacy Architecture](Icons/privacy.png)

## ⚠ IMPORTANT — AUTHORIZED USE ONLY

BrowserRecon is a specialized visual analysis and forensic utility intended **exclusively** for:
*   Controlled laboratory environments.
*   Authorized digital forensic investigations (DFIR).
*   Privacy auditing and self-investigation of personal data footprints.
*   SOC analyst workstations operating on authorized evidence copies.

**Legal Disclaimer**: Unauthorized access to computer systems or extraction of personal data is a criminal offense in most jurisdictions. You are solely responsible for ensuring that you have explicit, written authorization before extracting or analyzing data from any system you do not own.

---

## 🛡️ The Zero-Trust Analysis Promise

We recognize the sensitivity of browser history data. BrowserRecon is carefully engineered to give you absolute control over your environment, employing a strict Zero-Trust approach.

![Privacy Shield Overview](Icons/privacy_shield.png)

### 1. Purely Local Analysis
All data ingestion, processing, and visual rendering occur **100% locally** on your workstation. BrowserRecon does not stream telemetry, require external servers for UI rendering, or ship your personal data over the internet.

### 2. In-Memory Operations
Parsed history databases and visual intelligence metrics are constructed dynamically and reside inside application memory. Nothing is written permanently back to your hard drive outside of explicit export requests.

---

## 🛠️ Operational Guidelines & Constraints

### 1. Forensic Copy Protocol
BrowserRecon operates ideally on **forensic copies** (such as ZIP archives of User Data). This ensures that original evidence is never inadvertently modified or locked. We employ standard shadow-copying techniques when pointing directly at live browser folders to bypass active WAL (Write-Ahead Logging) locks. 

### 2. Evidence Integrity & Hashing
BrowserRecon currently prioritizes rapid visual triage over strict cryptographic handling of evidence. 
*   **Compliance Protocol**: You should hash and safeguard original forensic copies *before* analyzing them within BrowserRecon. The tool is read-only regarding source files but does not provide auto-hashing capabilities.

### 3. Scalability & Dataset Size
This software has been successfully stress-tested on typical multi-year history databases. 
*   However, compiling rich interactive visualizations (Treemaps, heatmaps, AI summaries) for massive datasets (>500,000 entries) may cause brief spikes in memory usage during the ingestion phase. Keep this in mind when dealing with unusually large profiles.

---

## 🧠 Using Advanced Enrichments

BrowserRecon includes powerful "Enrichment" layers that provide AI synthesis and intelligence screening, designed to respect operator privacy.

![Threat Intelligence Visualization](Icons/threat_intel.png)

*   **AI Case Narratives**: To ensure absolute privacy, cognitive narrations require a localized **Ollama** runtime. Your browser history is parsed directly against local models—it is never sent to OpenAI, Anthropic, or any other cloud provider.
*   **Threat Intel**: Integration with threat scoring requires API keys. These are saved locally into your configuration file and simply make standard GET requests to check domain reputation.

---

## 📁 End-of-Case Hygiene

When completing a review or switching clients, always follow this protocol to maintain forensic integrity between cases:

1.  **Export**: Save the current investigation as a `.brif` (Browser Recon Investigation File) bundle for archival and potential handoff to other analysts.
2.  **Purge**: Use the built-in **Purge Workspace** command to clear all in-memory data — history, cookies, bookmarks, extensions, downloads, domain cache, and AI reports.
3.  **Verify**: Confirm that all artifact counts return to zero before beginning a new case.

![Investigation Bundle Export](Icons/investigation_bundle.png)

This ensures complete data isolation between unrelated investigations and prevents evidence cross-contamination.

*BrowserRecon: Empowering Privacy through Transparency.*
