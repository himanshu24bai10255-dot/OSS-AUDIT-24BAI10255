# OSS Audit — Git
### Open Source Software Capstone Project

| | |
|---|---|
| **Student Name** | Himanshu Singhmar |
| **Registration Number** | 24BAI10255 |
| **Chosen Software** | Git |
| **Course** | Open Source Software (OSS NGMC) |
| **Repository** | `oss-audit-24BAI10255` |

---

## About This Project

This repository contains the shell scripts for the **Open Source Audit** capstone project. The project is a structured analysis of **Git** — the distributed version control system created by Linus Torvalds in 2005 under the GNU GPL v2 license.

The five scripts below demonstrate practical Linux skills and connect to the philosophy of open-source software: transparency, automation, and sharing.

---

## Chosen Software: Git

**Git** is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. It was created by Linus Torvalds in 2005 after the proprietary BitKeeper tool revoked free access from the Linux community.

- **License:** GNU General Public License v2 (GPL v2)
- **Official Site:** https://git-scm.com
- **Source Code:** https://github.com/git/git

---

## Repository Structure

```
oss-audit-24BAI10255/
├── README.md
├── script1_system_identity.sh
├── script2_package_inspector.sh
├── script3_disk_permission_auditor.sh
├── script4_log_analyzer.sh
└── script5_manifesto_generator.sh
```

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a welcome screen showing the Linux distribution, kernel version, current logged-in user, home directory, system uptime, date/time, and the open-source license covering the OS.

**Shell Concepts Used:** Variables, `echo`, command substitution `$()`, `case` statement, `uname`, `whoami`, `uptime`, `date`, `grep`, `/etc/os-release`

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether Git is installed on the system, retrieves its version and license information using the system package manager (RPM or dpkg), and prints a philosophical note about the software using a `case` statement.

**Shell Concepts Used:** `if-then-else`, `case` statement, `rpm -qi` / `dpkg -l`, pipe with `grep`, `command -v`

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_permission_auditor.sh`

Loops through a list of important Linux system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, etc.) and reports the size and permissions of each. Also specifically checks Git's binary and config file locations.

**Shell Concepts Used:** `for` loop, arrays `${DIRS[@]}`, `ls -ld`, `du -sh`, `df -h`, `awk`, `cut`

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts how many lines contain a given keyword (default: `error`), calculates the match percentage, and prints the last 5 matching lines. Supports a retry loop for empty files.

**Shell Concepts Used:** `while read` loop, `if-then`, counter variables, command-line arguments `$1` / `$2`, `grep`, `tail`, `awk` for percentage calculation

**Usage:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/auth.log failed
```

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions and generates a personalised open-source philosophy statement. Saves the output to a `.txt` file named after the current user.

**Shell Concepts Used:** `read` for interactive input, string concatenation, writing to file with `>` and `>>`, `date` command, alias concept (demonstrated via comment)

---

## How to Run the Scripts

### Prerequisites
- A Linux system (Ubuntu, Debian, Fedora, CentOS, Arch, or any standard distro)
- Bash shell (pre-installed on all Linux systems)
- Git installed: `sudo apt install git` or `sudo dnf install git`

### Step 1: Clone the Repository
```bash
git clone https://github.com/<your-username>/oss-audit-24BAI10255.git
cd oss-audit-24BAI10255
```

### Step 2: Make Scripts Executable
```bash
chmod +x *.sh
```

### Step 3: Run Each Script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
./script2_package_inspector.sh
```

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_permission_auditor.sh
```

**Script 4 — Log File Analyzer**
```bash
# Basic usage (searches for 'error' by default)
./script4_log_analyzer.sh /var/log/syslog

# Custom keyword
./script4_log_analyzer.sh /var/log/syslog WARNING

# On Ubuntu, try:
./script4_log_analyzer.sh /var/log/auth.log failed
```

**Script 5 — Manifesto Generator**
```bash
./script5_manifesto_generator.sh
# Follow the interactive prompts
# Output is saved to: manifesto_<username>.txt
```

---

## Dependencies

| Script | Dependencies | Install Command |
|--------|-------------|-----------------|
| Script 1 | `bash`, `uname`, `whoami`, `uptime`, `date` | Pre-installed on all Linux |
| Script 2 | `bash`, `rpm` or `dpkg`, `git` | `sudo apt install git` |
| Script 3 | `bash`, `ls`, `du`, `df`, `awk` | Pre-installed on all Linux |
| Script 4 | `bash`, `grep`, `tail`, `awk` | Pre-installed on all Linux |
| Script 5 | `bash`, `date`, `echo` | Pre-installed on all Linux |

---

## Testing Environment

Scripts were written and tested on:
- **OS:** Ubuntu 22.04 LTS / Debian-based Linux
- **Shell:** GNU Bash 5.x
- **Git Version:** 2.x

All scripts are compatible with RPM-based systems (Fedora, CentOS, RHEL) as well as dpkg-based systems (Ubuntu, Debian).

---

## Notes

- All scripts include inline comments explaining each section as required by the rubric.
- Script 4 requires a valid log file path as argument — see usage above.
- Script 5 is interactive and requires user input at runtime.
- Scripts have been written to handle edge cases (missing packages, empty files, missing directories).

---

## Academic Integrity

All code in this repository was written independently by Himanshu Singhmar (24BAI10255) for the OSS NGMC Capstone Project. No code has been copied from the internet without understanding. All shell concepts used are documented within the scripts themselves.

---

*Open Source Software Capstone | VITyarthi | 2024–25*
