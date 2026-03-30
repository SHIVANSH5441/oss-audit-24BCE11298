# oss-audit-24BCE11298
GitHub Repo Link for Open Source Software Project VIT Bhopal University

**Open Source Software Audit — Capstone Project**
VITyarthi | OSS NGMC Course

---

## Student Details

| Field | Details |
|---|---|
| **Student Name** | Shivansh Saraswat |
| **Registration Number** | 24BCE11298 |
| **Slot** | C-11 |
| **Chosen Software** | Git |
| **Course** | Open Source Software |

---

## About This Project

This repository contains all five shell scripts written as part of the Open Source Software Audit capstone project. The chosen software for this audit is **Git** — a free and open-source distributed version control system licensed under GPL v2. Each script demonstrates a different set of shell scripting concepts and is designed to run on a real Linux system (tested on Kali GNU/Linux).

---

## Repository Contents

```
oss-audit-24BCE11298/
├── README.md
├── script1.sh       # System Identity Report
├── script2.sh       # FOSS Package Inspector
├── script3.sh       # Disk and Permission Auditor
├── script4.sh       # Log File Analyzer
└── script5.sh       # Open Source Manifesto Generator
```

---

## Scripts

### Script 1 — System Identity Report
**Purpose:** Displays a welcome screen showing the Linux distribution name, kernel version, logged-in user, home directory, uptime, date/time, and a message about the OS licence.

**Concepts used:** Variables, `echo`, command substitution `$()`, `if-then-else`, `case` statement, `cut -d`, basic output formatting.

**How to run:**
```bash
chmod +x script1.sh
./script1.sh
```

**Dependencies:** None. Uses only standard Linux commands (`uname`, `whoami`, `hostname`, `uptime`, `date`).

---

### Script 2 — FOSS Package Inspector
**Purpose:** Checks whether Git is installed on the system, displays its version and package details, and uses a case statement to print a philosophy note about the software.

**Concepts used:** `if-then-elif-else`, `&>/dev/null` redirection, `dpkg -l`, `rpm -q`, pipe with `grep`, `awk`, `case` statement, `command -v`.

**How to run:**
```bash
chmod +x script2.sh
./script2.sh
```

**Dependencies:** `dpkg` (Debian/Ubuntu/Kali) or `rpm` (Fedora/CentOS/Red Hat). Git must be installed for full output.

---

### Script 3 — Disk and Permission Auditor
**Purpose:** Loops through a list of important system directories and reports the permissions, owner, group, and disk usage of each. Also checks Git-specific config file locations.

**Concepts used:** Bash arrays, `for` loop, `if [ -d ]`, `ls -ld`, `awk`, `du -sh`, `cut -f1`, `printf`, `2>/dev/null`.

**How to run:**
```bash
chmod +x script3.sh
./script3.sh
```

**Dependencies:** None. Uses standard Linux utilities (`ls`, `du`, `awk`, `printf`).

---

### Script 4 — Log File Analyzer
**Purpose:** Reads a log file line by line, counts occurrences of a keyword, prints a summary showing count and percentage, and displays the last 5 matching lines.

**Concepts used:** Command-line arguments `$1`/`$2`, default value syntax `${2:-"error"}`, counter variables, `while IFS= read -r`, `grep -iq`, `wc -l`, `tail -5`, arithmetic expansion `$(())`.

**How to run:**
```bash
chmod +x script4.sh
./script4.sh /var/log/dpkg.log install
```

> Replace `/var/log/dpkg.log` with any log file path and `install` with any keyword to search for.

**Dependencies:** `grep`, `wc`, `tail` — all standard on Linux.

---

### Script 5 — Open Source Manifesto Generator
**Purpose:** Asks the user three interactive questions, composes a personalised open source philosophy paragraph from their answers, and saves it to a `.txt` file.

**Concepts used:** `read -p`, string concatenation, `>` and `>>` file redirection, `date` command, `$(whoami)`, `-z` string test, functions (demonstrating the alias concept), `cat`.

**How to run:**
```bash
chmod +x script5.sh
./script5.sh
```

> The script will prompt you with three questions. Answer each one and it will generate a personalised manifesto saved as `manifesto_<username>.txt`.

**Dependencies:** None. Uses only built-in bash features and standard commands.

---

## How to Clone and Run

```bash
# Clone the repository
git clone https://github.com/ShivanshSaraswat/oss-audit-24BCE11298.git
cd oss-audit-24BCE11298

# Make all scripts executable at once
chmod +x *.sh

# Run any script
./script1.sh
```

---

## System Requirements

- Linux OS (tested on Kali GNU/Linux Rolling, kernel 6.12.13-amd64)
- Bash shell (`/bin/bash`)
- Standard Linux utilities: `uname`, `whoami`, `hostname`, `uptime`, `date`, `ls`, `du`, `awk`, `grep`, `wc`, `tail`
- Script 2 requires either `dpkg` or `rpm` depending on the distribution
- Script 4 requires a valid log file path as an argument

---

## License

This project is submitted as part of the VITyarthi OSS NGMC Course capstone assessment.
The chosen software, **Git**, is licensed under the **GNU General Public License v2 (GPL v2)**.
