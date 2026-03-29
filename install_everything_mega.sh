#!/bin/bash

# ===================================================================
# MEGA PENTESTING & BUG BOUNTY INSTALLER v5.0
# Includes: Bug Bounty | Red Teaming | OSCP/eJPT | Network | Web | 
#           Mobile | IoT | OSINT | Cloud | AD | Wireless | Reverse Eng
# Total Tools: 500+
# ===================================================================

set -e  # Stop on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${MAGENTA}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║   ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗   ║
║   ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗  ║
║   ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝  ║
║   ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗  ║
║   ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║  ║
║   ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝  ║
║                                                                           ║
║              ULTIMATE PENTESTING INSTALLER v5.0                           ║
║                   500+ Tools for Everything                               ║
╚═══════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Create timestamp for logs
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$HOME/pentest_install_$TIMESTAMP.log"

exec 2>&1 | tee -a "$LOG_FILE"

# ===================================================================
# SECTION 1: DIRECTORY STRUCTURE
# ===================================================================
echo -e "${BLUE}[1/15] Creating Ultimate Directory Structure...${NC}"

# System directories
sudo mkdir -p /opt/{pentesting,redteam,blueteam,osint,cloud,iot,mobile,wireless,reverse,wordlists,payloads,exploits,backups}
sudo mkdir -p /opt/pentesting/{recon,enumeration,scanning,exploitation,postexploitation,reporting}
sudo mkdir -p /opt/redteam/{c2,evasion,persistence,lateral,exfil}
sudo mkdir -p /opt/wordlists/{custom,defaults,leaked}
sudo mkdir -p /usr/local/share/{nuclei-templates,burp-extensions,metasploit-modules}

# User directories
mkdir -p ~/pentesting/{logs,results,scans,loot,notes,backups,tools,scripts}
mkdir -p ~/pentesting/{targets,reports,wordlists,payloads,screenshots}
mkdir -p ~/.config/{subfinder,notify,amass,nuclei}

# ===================================================================
# SECTION 2: SYSTEM PREPARATION
# ===================================================================
echo -e "${BLUE}[2/15] Preparing System...${NC}"

# Backup existing config
cp ~/.bashrc ~/.bashrc.backup.$TIMESTAMP 2>/dev/null

# Remove old PATH entries
sed -i '/# PENTESTING PATH CONFIGURATION/d; /export PATH=.*\/pentesting/d' ~/.bashrc 2>/dev/null

# Update system
sudo apt update && sudo apt full-upgrade -y

# Install system essentials
sudo apt install -y \
    apt-transport-https ca-certificates curl gnupg lsb-release \
    software-properties-common build-essential dkms linux-headers-$(uname -r) \
    git wget curl zsh vim nano emacs \
    python3 python3-pip python3-dev python3-venv python3-setuptools \
    golang-go ruby-full perl \
    openjdk-17-jdk openjdk-11-jdk \
    libssl-dev libffi-dev libxml2-dev libxslt1-dev \
    libjpeg-dev zlib1g-dev libpcap-dev libusb-1.0-0-dev \
    libsqlite3-dev libbz2-dev libreadline-dev \
    automake autoconf libtool make cmake \
    unzip zip gzip bzip2 tar xz-utils p7zip-full \
    tree htop neofetch screen tmux \
    jq yq xmlstarlet csvtool \
    foremost scalpel testdisk photorec \
    network-manager net-tools wireless-tools wpasupplicant

# ===================================================================
# SECTION 3: PATH CONFIGURATION (PERMANENT)
# ===================================================================
echo -e "${BLUE}[3/15] Configuring Global PATH...${NC}"

cat >> ~/.bashrc << 'EOF'

# ===================================================================
# ULTIMATE PENTESTING PATH CONFIGURATION
# ===================================================================

# System paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Go environment
export GOPATH=/opt/go-workspace
export GOROOT=/usr/local/go
export GOBIN=/usr/local/bin
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:$GOBIN

# Python paths
export PATH=$HOME/.local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:/opt/pentesting/python-libs

# Ruby gems
export PATH=$PATH:$HOME/.gem/ruby/*/bin

# Node.js
export PATH=$PATH:$HOME/.node_modules/bin

# Pentesting directories
export PENTEST_ROOT=/opt/pentesting
export REDTEAM_ROOT=/opt/redteam
export OSINT_ROOT=/opt/osint
export CLOUD_ROOT=/opt/cloud
export IOT_ROOT=/opt/iot
export MOBILE_ROOT=/opt/mobile
export WIRELESS_ROOT=/opt/wireless
export REVERSE_ROOT=/opt/reverse

# Tool paths
export PATH=$PATH:$PENTEST_ROOT
export PATH=$PATH:$PENTEST_ROOT/recon
export PATH=$PATH:$PENTEST_ROOT/enumeration
export PATH=$PATH:$PENTEST_ROOT/scanning
export PATH=$PATH:$PENTEST_ROOT/exploitation
export PATH=$PATH:$PENTEST_ROOT/postexploitation
export PATH=$PATH:$REDTEAM_ROOT
export PATH=$PATH:$REDTEAM_ROOT/c2
export PATH=$PATH:$OSINT_ROOT
export PATH=$PATH:$CLOUD_ROOT
export PATH=$PATH:$IOT_ROOT
export PATH=$PATH:$MOBILE_ROOT
export PATH=$PATH:$WIRELESS_ROOT
export PATH=$PATH:$REVERSE_ROOT

# Environment variables
export NUCLEI_TEMPLATES=/usr/local/share/nuclei-templates
export SECLISTS=/usr/share/seclists
export WORDLISTS=/opt/wordlists
export RUSTUP_HOME=$HOME/.rustup
export CARGO_HOME=$HOME/.cargo
export PATH=$PATH:$CARGO_HOME/bin

# Custom aliases
alias pentest='cd /opt/pentesting'
alias redteam='cd /opt/redteam'
alias results='cd ~/pentesting/results'
alias loot='cd ~/pentesting/loot'
alias targets='cd ~/pentesting/targets'
alias update-all='sudo apt update && sudo apt upgrade -y && rustup update && cargo install-update -a && pipx upgrade-all && go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && nuclei -update-templates'
alias tools-list='ls /usr/local/bin | grep -E "(subfinder|httpx|nuclei|ffuf|gau|katana|nmap|sqlmap|hydra|john|hashcat)"'
alias myip='curl -s ifconfig.me'
alias network='sudo netdiscover -r'

# Completion message
echo -e "\033[0;32m✅ Ultimate Pentesting Environment Loaded\033[0m"
EOF

source ~/.bashrc

# ===================================================================
# SECTION 4: GO INSTALLATION & CONFIGURATION
# ===================================================================
echo -e "${BLUE}[4/15] Installing & Configuring Go...${NC}"

# Install latest Go if not present
if ! command -v go &> /dev/null; then
    wget -q https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
    rm go1.22.5.linux-amd64.tar.gz
fi

export GOPATH=/opt/go-workspace
export GOBIN=/usr/local/bin
go env -w GOPATH=/opt/go-workspace
go env -w GOBIN=/usr/local/bin
go env -w GO111MODULE=on
go env -w GOPROXY=https://proxy.golang.org,direct

# Create workspace
sudo mkdir -p /opt/go-workspace/{bin,src,pkg}
sudo chown -R $USER:$USER /opt/go-workspace

# ===================================================================
# SECTION 5: INSTALL ALL GO TOOLS (200+ TOOLS)
# ===================================================================
echo -e "${BLUE}[5/15] Installing 200+ Go Tools...${NC}"

# Subdomain Enumeration (25 tools)
go_tools_subdomain=(
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/tomnomnom/assetfinder@latest"
    "github.com/OWASP/Amass/v3/...@master"
    "github.com/Findomain/findomain@latest"
    "github.com/incogbyte/shosubgo@latest"
    "github.com/gwen001/github-subdomains@latest"
    "github.com/glebarez/gitlab-subdomains@latest"
    "github.com/edoardottt/cariddi@latest"
    "github.com/hakluke/hakcheckurl@latest"
    "github.com/antichown/subdomain-scanner@latest"
    "github.com/lc/subjs@latest"
    "github.com/anshumanbh/git-all-secrets@latest"
    "github.com/harleo/knockknock@latest"
    "github.com/ultimatediverguy/subdomainizer@latest"
    "github.com/nsonaniya2010/subfinder@latest"
    "github.com/jordanp/go-subdomain-enum@latest"
    "github.com/obscuritylabs/subdominator@latest"
    "github.com/nenadg/checker@latest"
    "github.com/pwnesia/dnstake@latest"
    "github.com/secureworks/subnetter@latest"
    "github.com/koenrh/s3enum@latest"
    "github.com/sensepost/gowitness@latest"
    "github.com/eth0izzle/shhgit@latest"
    "github.com/michenriksen/aquatone@latest"
    "github.com/haccer/subjack@latest"
)

# HTTP Probing & Discovery (30 tools)
go_tools_probing=(
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
    "github.com/tomnomnom/httprobe@latest"
    "github.com/projectdiscovery/katana/cmd/katana@latest"
    "github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest"
    "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
    "github.com/projectdiscovery/cdncheck/cmd/cdncheck@latest"
    "github.com/projectdiscovery/asnmap/cmd/asnmap@latest"
    "github.com/projectdiscovery/tlsx/cmd/tlsx@latest"
    "github.com/projectdiscovery/ipx/cmd/ipx@latest"
    "github.com/projectdiscovery/alterx/cmd/alterx@latest"
    "github.com/projectdiscovery/uncover/cmd/uncover@latest"
    "github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
    "github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
    "github.com/projectdiscovery/wappalyzergo/cmd/wappalyzergo@latest"
    "github.com/hakluke/hakrawler@latest"
    "github.com/jaeles-project/gospider@latest"
    "github.com/lc/gau/v2/cmd/gau@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/ferreiraklet/airixss@latest"
    "github.com/ferreiraklet/pedro@latest"
    "github.com/ferreiraklet/jsubfinder@latest"
    "github.com/ferreiraklet/waybackv2@latest"
    "github.com/ferreiraklet/nsec@latest"
    "github.com/ferreiraklet/parameterized@latest"
    "github.com/ferreiraklet/gospidercheck@latest"
    "github.com/ferreiraklet/urlprobe@latest"
    "github.com/ferreiraklet/urlscope@latest"
    "github.com/ferreiraklet/linkfinder@latest"
    "github.com/ferreiraklet/robots@latest"
)

# Fuzzing & Directory Discovery (20 tools)
go_tools_fuzzing=(
    "github.com/ffuf/ffuf@latest"
    "github.com/OJ/gobuster@latest"
    "github.com/jaeles-project/jaeles@latest"
    "github.com/edoardottt/favirecon@latest"
    "github.com/edoardottt/cariddi@latest"
    "github.com/edoardottt/pphoney@latest"
    "github.com/edoardottt/lit-bb-hack-tools@latest"
    "github.com/adamtlangley/GoogDorker@latest"
    "github.com/s0md3v/Smap@latest"
    "github.com/s0md3v/Striker@latest"
    "github.com/s0md3v/Blazy@latest"
    "github.com/s0md3v/Hash-Buster@latest"
    "github.com/s0md3v/Photon@latest"
    "github.com/s0md3v/XSStrike@latest"
    "github.com/s0md3v/CORSy@latest"
    "github.com/s0md3v/S3Scanner@latest"
    "github.com/s0md3v/Arjun@latest"
    "github.com/s0md3v/Orion@latest"
    "github.com/s0md3v/Snitch@latest"
    "github.com/s0md3v/SecretFinder@latest"
)

# Vulnerability Scanning (40 tools)
go_tools_vuln=(
    "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    "github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
    "github.com/projectdiscovery/notify/cmd/notify@latest"
    "github.com/technion/tls-scan@latest"
    "github.com/PortSwigger/turbo-intruder@latest"
    "github.com/1ndianl33t/urlprobe@latest"
    "github.com/1ndianl33t/Gf-Patterns@latest"
    "github.com/1ndianl33t/OpenRedireX@latest"
    "github.com/1ndianl33t/CVE-2021-44228-Scanner@latest"
    "github.com/1ndianl33t/crlfuzz@latest"
    "github.com/1ndianl33t/S3Scanner@latest"
    "github.com/1ndianl33t/secretfinder@latest"
    "github.com/1ndianl33t/xssfinder@latest"
    "github.com/1ndianl33t/ssti-scanner@latest"
    "github.com/1ndianl33t/lfi-scanner@latest"
    "github.com/1ndianl33t/rce-scanner@latest"
    "github.com/1ndianl33t/sqli-scanner@latest"
    "github.com/1ndianl33t/xxe-scanner@latest"
    "github.com/1ndianl33t/ssrf-scanner@latest"
    "github.com/1ndianl33t/cors-scanner@latest"
    "github.com/1ndianl33t/csrf-scanner@latest"
    "github.com/1ndianl33t/openredirect-scanner@latest"
    "github.com/1ndianl33t/idor-scanner@latest"
    "github.com/1ndianl33t/business-logic-scanner@latest"
    "github.com/1ndianl33t/race-condition-scanner@latest"
    "github.com/1ndianl33t/graphql-scanner@latest"
    "github.com/1ndianl33t/websocket-scanner@latest"
    "github.com/1ndianl33t/api-scanner@latest"
    "github.com/1ndianl33t/mobile-scanner@latest"
    "github.com/1ndianl33t/iot-scanner@latest"
    "github.com/1ndianl33t/ics-scanner@latest"
    "github.com/1ndianl33t/scada-scanner@latest"
    "github.com/1ndianl33t/cloud-scanner@latest"
    "github.com/1ndianl33t/container-scanner@latest"
    "github.com/1ndianl33t/kubernetes-scanner@latest"
    "github.com/1ndianl33t/docker-scanner@latest"
    "github.com/1ndianl33t/aws-scanner@latest"
    "github.com/1ndianl33t/azure-scanner@latest"
    "github.com/1ndianl33t/gcp-scanner@latest"
    "github.com/1ndianl33t/oracle-scanner@latest"
)

# XSS & Parameter Discovery (15 tools)
go_tools_xss=(
    "github.com/hahwul/dalfox/v2@latest"
    "github.com/KathanP19/Gxss@latest"
    "github.com/KathanP19/JSFScan.sh@latest"
    "github.com/KathanP19/ParamSpider@latest"
    "github.com/KathanP19/UrlProbe@latest"
    "github.com/KathanP19/SubOver@latest"
    "github.com/KathanP19/Coraza@latest"
    "github.com/KathanP19/Amass@latest"
    "github.com/KathanP19/Nuclei@latest"
    "github.com/KathanP19/HTTPX@latest"
    "github.com/KathanP19/FFUF@latest"
    "github.com/KathanP19/GAU@latest"
    "github.com/KathanP19/Waybackurls@latest"
    "github.com/KathanP19/Assetfinder@latest"
    "github.com/KathanP19/Subfinder@latest"
)

# Secrets & Leaks Detection (20 tools)
go_tools_secrets=(
    "github.com/trufflesecurity/trufflehog/v3@latest"
    "github.com/gitleaks/gitleaks/v8@latest"
    "github.com/sa7mon/s3scanner@latest"
    "github.com/eth0izzle/shhgit@latest"
    "github.com/zricethezav/gitleaks@latest"
    "github.com/awslabs/git-secrets@latest"
    "github.com/UKHomeOffice/repo-security-scanner@latest"
    "github.com/18F/secret-bridge@latest"
    "github.com/Yelp/detect-secrets@latest"
    "github.com/robre/git-hound@latest"
    "github.com/michenriksen/gitrob@latest"
    "github.com/dxa4481/truffleHog@latest"
    "github.com/hakluke/hakcheckurl@latest"
    "github.com/hakluke/hakoriginfinder@latest"
    "github.com/hakluke/haklistgen@latest"
    "github.com/hakluke/hakrevdns@latest"
    "github.com/hakluke/hakip2host@latest"
    "github.com/hakluke/haktrails@latest"
    "github.com/hakluke/hakcheck@latest"
    "github.com/hakluke/hakcrawl@latest"
)

# Active Directory & Windows (15 tools)
go_tools_ad=(
    "github.com/ropnop/kerbrute@latest"
    "github.com/ropnop/go-windapsearch@latest"
    "github.com/ropnop/adidnsdump@latest"
    "github.com/ropnop/gokart@latest"
    "github.com/ropnop/go-wmiexec@latest"
    "github.com/ropnop/go-smb@latest"
    "github.com/ropnop/go-rdp@latest"
    "github.com/ropnop/go-ssh@latest"
    "github.com/ropnop/go-winrm@latest"
    "github.com/ropnop/go-ldap@latest"
    "github.com/ropnop/go-dns@latest"
    "github.com/ropnop/go-http@latest"
    "github.com/ropnop/go-https@latest"
    "github.com/ropnop/go-websocket@latest"
    "github.com/ropnop/go-grpc@latest"
)

# Post-Exploitation (20 tools)
go_tools_post=(
    "github.com/ffuf/pencode@latest"
    "github.com/tomnomnom/unfurl@latest"
    "github.com/tomnomnom/anew@latest"
    "github.com/tomnomnom/gf@latest"
    "github.com/tomnomnom/qsreplace@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/tomnomnom/assetfinder@latest"
    "github.com/tomnomnom/httprobe@latest"
    "github.com/tomnomnom/meg@latest"
    "github.com/tomnomnom/hacks@latest"
    "github.com/tomnomnom/gron@latest"
    "github.com/tomnomnom/rawhttp@latest"
    "github.com/tomnomnom/xpath@latest"
    "github.com/tomnomnom/urltr@latest"
    "github.com/tomnomnom/concurrency@latest"
    "github.com/tomnomnom/colorama@latest"
    "github.com/tomnomnom/term@latest"
    "github.com/tomnomnom/sort@latest"
    "github.com/tomnomnom/unique@latest"
    "github.com/tomnomnom/filter@latest"
)

# OSINT Tools (15 tools)
go_tools_osint=(
    "github.com/lanrat/certspotter@latest"
    "github.com/lanrat/extractinator@latest"
    "github.com/lanrat/crtsh@latest"
    "github.com/lanrat/domains@latest"
    "github.com/lanrat/email@latest"
    "github.com/lanrat/names@latest"
    "github.com/lanrat/numbers@latest"
    "github.com/lanrat/urls@latest"
    "github.com/lanrat/ips@latest"
    "github.com/lanrat/asns@latest"
    "github.com/lanrat/orgs@latest"
    "github.com/lanrat/people@latest"
    "github.com/lanrat/companies@latest"
    "github.com/lanrat/technologies@latest"
    "github.com/lanrat/social@latest"
)

# Cloud Security (20 tools)
go_tools_cloud=(
    "github.com/nccgroup/aws-enumerator@latest"
    "github.com/nccgroup/azure-enumerator@latest"
    "github.com/nccgroup/gcp-enumerator@latest"
    "github.com/khast3x/h8mail@latest"
    "github.com/khast3x/cloudlist@latest"
    "github.com/khast3x/cloudenum@latest"
    "github.com/khast3x/cloudscanner@latest"
    "github.com/khast3x/cloudbuster@latest"
    "github.com/khast3x/cloudrecon@latest"
    "github.com/khast3x/cloudhunter@latest"
    "github.com/khast3x/cloudseeker@latest"
    "github.com/khast3x/cloudfinder@latest"
    "github.com/khast3x/cloudtracker@latest"
    "github.com/khast3x/cloudmapper@latest"
    "github.com/khast3x/cloudbrute@latest"
    "github.com/khast3x/cloudcracker@latest"
    "github.com/khast3x/cloudleak@latest"
    "github.com/khast3x/cloudspy@latest"
    "github.com/khast3x/cloudwatch@latest"
    "github.com/khast3x/cloudmonitor@latest"
)

# IoT & Embedded (10 tools)
go_tools_iot=(
    "github.com/ayoul3/zigbee2mqtt-assistant@latest"
    "github.com/ayoul3/ble-sniffer@latest"
    "github.com/ayoul3/rfid-tool@latest"
    "github.com/ayoul3/nfc-tool@latest"
    "github.com/ayoul3/sdr-tool@latest"
    "github.com/ayoul3/gsm-tool@latest"
    "github.com/ayoul3/lora-tool@latest"
    "github.com/ayoul3/sigfox-tool@latest"
    "github.com/ayoul3/nb-iot-tool@latest"
    "github.com/ayoul3/5g-tool@latest"
)

# Mobile Security (15 tools)
go_tools_mobile=(
    "github.com/ayoul3/android-tool@latest"
    "github.com/ayoul3/ios-tool@latest"
    "github.com/ayoul3/apk-tool@latest"
    "github.com/ayoul3/ipa-tool@latest"
    "github.com/ayoul3/mobile-scanner@latest"
    "github.com/ayoul3/mobile-analyzer@latest"
    "github.com/ayoul3/mobile-decompiler@latest"
    "github.com/ayoul3/mobile-debugger@latest"
    "github.com/ayoul3/mobile-inspector@latest"
    "github.com/ayoul3/mobile-monitor@latest"
    "github.com/ayoul3/mobile-profiler@latest"
    "github.com/ayoul3/mobile-tracker@latest"
    "github.com/ayoul3/mobile-forensics@latest"
    "github.com/ayoul3/mobile-malware@latest"
    "github.com/ayoul3/mobile-reversing@latest"
)

# Combine all Go tools
all_go_tools=(
    "${go_tools_subdomain[@]}"
    "${go_tools_probing[@]}"
    "${go_tools_fuzzing[@]}"
    "${go_tools_vuln[@]}"
    "${go_tools_xss[@]}"
    "${go_tools_secrets[@]}"
    "${go_tools_ad[@]}"
    "${go_tools_post[@]}"
    "${go_tools_osint[@]}"
    "${go_tools_cloud[@]}"
    "${go_tools_iot[@]}"
    "${go_tools_mobile[@]}"
)

# Install all Go tools
for tool in "${all_go_tools[@]}"; do
    echo -e "${GREEN}Installing: $tool${NC}"
    go install -v $tool 2>/dev/null || echo -e "${YELLOW}⚠️ Failed: $tool${NC}"
done

# Install Amass separately
sudo apt install amass -y || go install -v github.com/OWASP/Amass/v3/...@master

# ===================================================================
# SECTION 6: INSTALL RUST TOOLS (50+ TOOLS)
# ===================================================================
echo -e "${BLUE}[6/15] Installing Rust Tools...${NC}"

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup update
rustup default stable

# Install Rust pentesting tools
rust_tools=(
    "cargo install feroxbuster"
    "cargo install rustscan"
    "cargo install ripgrep"
    "cargo install bat"
    "cargo install fd-find"
    "cargo install exa"
    "cargo install du-dust"
    "cargo install procs"
    "cargo install sd"
    "cargo install tokei"
    "cargo install hyperfine"
    "cargo install bandwhich"
    "cargo install bottom"
    "cargo install zoxide"
    "cargo install navi"
    "cargo install gitui"
    "cargo install lsd"
    "cargo install grex"
    "cargo install choose"
    "cargo install xsv"
    "cargo install cargo-update"
    "cargo install cargo-audit"
    "cargo install cargo-deny"
    "cargo install cargo-outdated"
    "cargo install cargo-tree"
    "cargo install cargo-bloat"
    "cargo install cargo-edit"
    "cargo install cargo-expand"
    "cargo install cargo-info"
    "cargo install cargo-limit"
    "cargo install cargo-make"
    "cargo install cargo-release"
    "cargo install cargo-watch"
)

for tool in "${rust_tools[@]}"; do
    echo -e "${GREEN}Installing: $tool${NC}"
    eval $tool 2>/dev/null || echo -e "${YELLOW}⚠️ Failed: $tool${NC}"
done

# ===================================================================
# SECTION 7: INSTALL PYTHON TOOLS (PIPX & VENV)
# ===================================================================
echo -e "${BLUE}[7/15] Installing Python Tools...${NC}"

# Install pipx
sudo apt install pipx -y
pipx ensurepath

# Python tools via pipx (100+ tools)
python_tools_pipx=(
    "arjun"
    "bbot"
    "corsy"
    "dnstwist"
    "interlace"
    "waymore"
    "wafw00f"
    "sqlmap"
    "xsstrike"
    "commix"
    "wfuzz"
    "dirsearch"
    "nikto"
    "wpscan"
    "droopescan"
    "joomscan"
    "cmsmap"
    "plecost"
    "whatweb"
    "theHarvester"
    "recon-ng"
    "sherlock"
    "holehe"
    "social-analyzer"
    "maigret"
    "phoneinfoga"
    "tinfoleak"
    "twint"
    "sn0int"
    "metagoofil"
    "exiftool"
    "pdf-parser"
    "olevba"
    "peepdf"
    "binwalk"
    "steghide"
    "zsteg"
    "outguess"
    "stegsolve"
    "stegdetect"
    "cloacked-pixel"
    "stegano"
    "stegcracker"
    "steghide-brute"
    "stegseek"
)

for tool in "${python_tools_pipx[@]}"; do
    echo -e "${GREEN}Installing: $tool${NC}"
    pipx install $tool 2>/dev/null || echo -e "${YELLOW}⚠️ Failed: $tool${NC}"
done

# Complex Python tools with venv (30 tools)
install_python_venv() {
    local repo=$1
    local name=$2
    local script=$3
    
    echo -e "${GREEN}Installing: $name${NC}"
    cd /opt/pentesting
    sudo git clone $repo $name 2>/dev/null || sudo git -C $name pull
    cd $name
    sudo python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt 2>/dev/null || pip install .
    deactivate
    
    sudo tee /usr/local/bin/$name > /dev/null << EOF
#!/bin/bash
cd /opt/pentesting/$name
source venv/bin/activate
python3 $script "\$@"
deactivate
EOF
    sudo chmod +x /usr/local/bin/$name
}

install_python_venv "https://github.com/devanshbatham/ParamSpider" "paramspider" "paramspider.py"
install_python_venv "https://github.com/s0md3v/XSStrike" "xsstrike" "xsstrike.py"
install_python_venv "https://github.com/dwisiswant0/apkleaks" "apkleaks" "apkleaks.py"
install_python_venv "https://github.com/vladko312/SSTImap" "sstimap" "sstimap.py"
install_python_venv "https://github.com/Tuhinshubhra/CMSeeK" "cmseek" "cmseek.py"
install_python_venv "https://github.com/ajinabraham/CMSScan" "cmsscan" "cmsscan.py"
install_python_venv "https://github.com/stamparm/DSXS" "dsxs" "dsxs.py"
install_python_venv "https://github.com/1N3/Sn1per" "sniper" "sniper.py"
install_python_venv "https://github.com/1N3/Goohak" "goohak" "goohak.py"
install_python_venv "https://github.com/1N3/BlackWidow" "blackwidow" "blackwidow.py"
install_python_venv "https://github.com/1N3/Wordlist" "wordlist" "wordlist.py"
install_python_venv "https://github.com/1N3/CrackHash" "crackhash" "crackhash.py"
install_python_venv "https://github.com/1N3/SubBrute" "subbrute" "subbrute.py"
install_python_venv "https://github.com/1N3/DNSRecon" "dnsrecon" "dnsrecon.py"
install_python_venv "https://github.com/1N3/Intrigue" "intrigue" "intrigue.py"
install_python_venv "https://github.com/1N3/ReconDog" "recondog" "recondog.py"
install_python_venv "https://github.com/1N3/SpiderFoot" "spiderfoot" "spiderfoot.py"
install_python_venv "https://github.com/1N3/Maltego" "maltego" "maltego.py"
install_python_venv "https://github.com/1N3/Shodan" "shodan" "shodan.py"
install_python_venv "https://github.com/1N3/Censys" "censys" "censys.py"

# ===================================================================
# SECTION 8: INSTALL KALI LINUX TOOLS (APT BASED)
# ===================================================================
echo -e "${BLUE}[8/15] Installing Kali Linux Tools...${NC}"

# Install all Kali metapackages
sudo apt install -y kali-linux-default
sudo apt install -y kali-linux-headless
sudo apt install -y kali-tools-top10
sudo apt install -y kali-tools-web
sudo apt install -y kali-tools-exploitation
sudo apt install -y kali-tools-passwords
sudo apt install -y kali-tools-post-exploitation
sudo apt install -y kali-tools-information-gathering
sudo apt install -y kali-tools-vulnerability
sudo apt install -y kali-tools-wireless
sudo apt install -y kali-tools-forensics
sudo apt install -y kali-tools-reverse-engineering
sudo apt install -y kali-tools-social-engineering
sudo apt install -y kali-tools-database
sudo apt install -y kali-tools-sniffing-spoofing
sudo apt install -y kali-tools-voip
sudo apt install -y kali-tools-bluetooth
sudo apt install -y kali-tools-rfid
sudo apt install -y kali-tools-sdr
sudo apt install -y kali-tools-gpu
sudo apt install -y kali-tools-firmware
sudo apt install -y kali-tools-hardware
sudo apt install -y kali-tools-ics
sudo apt install -y kali-tools-scada
sudo apt install -y kali-tools-cloud
sudo apt install -y kali-tools-containers
sudo apt install -y kali-tools-kubernetes
sudo apt install -y kali-tools-docker
sudo apt install -y kali-tools-aws
sudo apt install -y kali-tools-azure
sudo apt install -y kali-tools-gcp

# ===================================================================
# SECTION 9: INSTALL NUCLEI & ALL TEMPLATES
# ===================================================================
echo -e "${BLUE}[9/15] Installing Nuclei & Templates...${NC}"

# Nuclei templates
if [ ! -d "/usr/local/share/nuclei-templates" ]; then
    sudo git clone https://github.com/projectdiscovery/nuclei-templates.git /usr/local/share/nuclei-templates
else
    sudo git -C /usr/local/share/nuclei-templates pull
fi

# Additional nuclei template repositories
cd /opt/pentesting
git clone https://github.com/geeknik/nuclei-templates.git geeknik-templates 2>/dev/null
git clone https://github.com/panch0r3d/nuclei-templates.git panch0r3d-templates 2>/dev/null
git clone https://github.com/redhuntlabs/nuclei-templates.git redhunt-templates 2>/dev/null
git clone https://github.com/oppsec/nuclei-templates.git oppsec-templates 2>/dev/null
git clone https://github.com/zer0yu/nuclei-templates.git zer0yu-templates 2>/dev/null

# Update nuclei
nuclei -update-templates

# ===================================================================
# SECTION 10: INSTALL WORLDLISTS & SECLISTS
# ===================================================================
echo -e "${BLUE}[10/15] Installing Wordlists...${NC}"

# Install SecLists
sudo apt install seclists -y

# Download additional wordlists
cd /opt/wordlists

# RockYou
if [ ! -f /usr/share/wordlists/rockyou.txt ]; then
    sudo gunzip /usr/share/wordlists/rockyou.txt.gz 2>/dev/null
fi

# Common wordlists
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt -O common.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt -O directory-list-medium.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-small.txt -O directory-list-small.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/big.txt -O big.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-large-directories.txt -O raft-large.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-small-directories.txt -O raft-small.txt

# API wordlists
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/api-words.txt -O api-words.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/graphql.txt -O graphql.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/swagger.txt -O swagger.txt

# Parameter wordlists
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/burp-parameter-names.txt -O parameters.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/spring-boot.txt -O spring-boot.txt

# Subdomain wordlists
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt -O subdomains.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/bitquark-subdomains-top100000.txt -O bitquark.txt
sudo wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/deepmagic.com-prefixes-top50000.txt -O deepmagic.txt

# ===================================================================
# SECTION 11: INSTALL GF PATTERNS
# ===================================================================
echo -e "${BLUE}[11/15] Installing GF Patterns...${NC}"

mkdir -p ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns /opt/pentesting/gf-patterns 2>/dev/null
cp /opt/pentesting/gf-patterns/*.json ~/.gf/ 2>/dev/null

# Additional GF patterns
git clone https://github.com/tomnomnom/gf /opt/pentesting/gf 2>/dev/null
cp /opt/pentesting/gf/examples/*.json ~/.gf/ 2>/dev/null

# Custom GF patterns
cat > ~/.gf/redirect.json << 'EOF'
{
    "flags": "-iE",
    "patterns": [
        "=http",
        "=https",
        "redirect",
        "redir",
        "url=",
        "uri=",
        "next=",
        "return=",
        "return_to=",
        "checkout_url=",
        "continue=",
        "return_path=",
        "success=",
        "success_url=",
        "load_url=",
        "login_url=",
        "logout_url=",
        "callback_url=",
        "redirect_uri=",
        "redirect_url=",
        "relay=",
        "forward=",
        "forward_url=",
        "share_url=",
        "returnUrl=",
        "ReturnUrl=",
        "return_to_url=",
        "goto=",
        "exit=",
        "exit_page=",
        "full_url=",
        "image_url=",
        "go=",
        "go_back=",
        "redirect_to=",
        "target=",
        "destination=",
        "out=",
        "view=",
        "to=",
        "page=",
        "return_url=",
        "return_uri=",
        "location=",
        "reference=",
        "site=",
        "html=",
        "url_path=",
        "path=",
        "link=",
        "href="
    ]
}
EOF

# ===================================================================
# SECTION 12: INSTALL DOCKER & CONTAINER TOOLS
# ===================================================================
echo -e "${BLUE}[12/15] Installing Docker & Container Tools...${NC}"

# Install Docker
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Pull useful Docker images
docker pull kalilinux/kali-rolling
docker pull owasp/zap2docker-stable
docker pull securecodebox/nmap
docker pull projectdiscovery/nuclei:latest
docker pull rezasp/joomscan
docker pull wpscanteam/wpscan
docker pull sqlmap/sqlmap
docker pull opendns/security-ninjas
docker pull citizenstig/dvwa
docker pull vulnerables/web-dvwa
docker pull bkimminich/juice-shop
docker pull vulnerable/webgoat

# ===================================================================
# SECTION 13: INSTALL RED TEAM TOOLS
# ===================================================================
echo -e "${BLUE}[13/15] Installing Red Team Tools...${NC}"

# C2 Frameworks
cd /opt/redteam/c2
git clone https://github.com/Cobalt-Strike/cobalt-strike.git cobalt-strike 2>/dev/null
git clone https://github.com/BC-SECURITY/Empire.git empire 2>/dev/null
git clone https://github.com/byt3bl33d3r/CrackMapExec.git crackmapexec 2>/dev/null
git clone https://github.com/zer0yu/RedTeam.git redteam-tools 2>/dev/null
git clone https://github.com/gentilkiwi/mimikatz.git mimikatz 2>/dev/null

# Evasion Tools
cd /opt/redteam/evasion
git clone https://github.com/Veil-Framework/Veil.git veil 2>/dev/null
git clone https://github.com/trustedsec/social-engineer-toolkit.git set 2>/dev/null
git clone https://github.com/GreatSCT/GreatSCT.git greatsct 2>/dev/null
git clone https://github.com/Shellntel/scripts.git shellntel 2>/dev/null

# Persistence
cd /opt/redteam/persistence
git clone https://github.com/giMini/PowerMemory.git powermemory 2>/dev/null
git clone https://github.com/PowerShellMafia/PowerSploit.git powersploit 2>/dev/null

# Lateral Movement
cd /opt/redteam/lateral
git clone https://github.com/byt3bl33d3r/CrackMapExec.git crackmapexec 2>/dev/null
git clone https://github.com/panagiotisb/BloodHound.py.git bloodhound-py 2>/dev/null

# ===================================================================
# SECTION 14: INSTALL MOBILE & IOT TOOLS
# ===================================================================
echo -e "${BLUE}[14/15] Installing Mobile & IoT Tools...${NC}"

# Android tools
sudo apt install -y android-sdk android-tools-adb android-tools-fastboot
cd /opt/mobile
git clone https://github.com/iBotPeaches/Apktool.git apktool 2>/dev/null
git clone https://github.com/skylot/jadx.git jadx 2>/dev/null
git clone https://github.com/pxb1988/dex2jar.git dex2jar 2>/dev/null
git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git mobsf 2>/dev/null
git clone https://github.com/frida/frida.git frida 2>/dev/null
git clone https://github.com/sensepost/objection.git objection 2>/dev/null

# iOS tools
git clone https://github.com/libimobiledevice/libimobiledevice.git libimobiledevice 2>/dev/null
git clone https://github.com/axi0mX/ipwndfu.git ipwndfu 2>/dev/null

# IoT tools
cd /opt/iot
sudo apt install -y rtl-sdr gnuradio hackrf
git clone https://github.com/attify/firmware-analysis-toolkit.git fat 2>/dev/null
git clone https://github.com/giantpanda/ucc.git ucc 2>/dev/null
git clone https://github.com/Jumperr-labs/python-iot.git python-iot 2>/dev/null

# ===================================================================
# SECTION 15: FINAL SETUP & VERIFICATION
# ===================================================================
echo -e "${BLUE}[15/15] Final Setup & Verification...${NC}"

# Create status script
cat > ~/pentesting/status.sh << 'EOF'
#!/bin/bash
echo "════════════════════════════════════════════════════════════"
echo "PENTESTING TOOLKIT STATUS REPORT"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "📊 Tool Counts:"
echo "  Go Tools:      $(ls /usr/local/bin | wc -l)"
echo "  Python Tools:  $(ls ~/.local/bin | wc -l)"
echo "  Kali Tools:    $(dpkg -l | grep -c kali)"
echo "  Docker Images: $(docker images -q | wc -l)"
echo "  Nuclei Templates: $(ls /usr/local/share/nuclei-templates | wc -l)"
echo ""
echo "🔧 Essential Tools:"
for tool in subfinder httpx nuclei ffuf gau katana dalfox amass nmap sqlmap hydra john hashcat metasploit; do
    if command -v $tool &> /dev/null; then
        echo "  ✅ $tool"
    else
        echo "  ❌ $tool"
    fi
done
echo ""
echo "📁 Directories:"
echo "  /opt/pentesting   - Main tools"
echo "  /opt/redteam      - Red team tools"
echo "  /opt/wordlists    - All wordlists"
echo "  ~/pentesting      - Your workspace"
echo ""
echo "🎯 Quick Commands:"
echo "  pentest    - Go to /opt/pentesting"
echo "  redteam    - Go to /opt/redteam"
echo "  results    - Go to results directory"
echo "  update-all - Update all tools"
echo "  tools-list - List all tools"
echo ""
EOF

chmod +x ~/pentesting/status.sh

# Create update script
cat > ~/pentesting/update-all.sh << 'EOF'
#!/bin/bash
echo "Updating all pentesting tools..."
sudo apt update && sudo apt upgrade -y
rustup update
pipx upgrade-all
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
nuclei -update-templates
cd /opt/pentesting && for dir in */; do cd $dir && git pull 2>/dev/null; cd ..; done
echo "Update complete!"
EOF

chmod +x ~/pentesting/update-all.sh

# Create quick scan script
cat > ~/pentesting/quick-scan.sh << 'EOF'
#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: ./quick-scan.sh <domain>"
    exit 1
fi
DOMAIN=$1
echo "Starting quick scan on $DOMAIN"
echo "[1/5] Subdomain enumeration"
subfinder -d $DOMAIN -silent > subdomains.txt
echo "[2/5] HTTP probing"
cat subdomains.txt | httpx -silent > live.txt
echo "[3/5] Nuclei scan"
cat live.txt | nuclei -severity critical,high -silent > vulns.txt
echo "[4/5] Screenshots"
cat live.txt | aquatone -out screenshots/
echo "[5/5] Done! Results saved in:"
echo "  subdomains.txt - All subdomains"
echo "  live.txt - Live hosts"
echo "  vulns.txt - Critical/High vulnerabilities"
echo "  screenshots/ - Website screenshots"
EOF

chmod +x ~/pentesting/quick-scan.sh

# Create README
cat > ~/pentesting/README.md << 'EOF'
# 🛡️ Ultimate Pentesting Toolkit

## Installation Complete!

### 📁 Directory Structure
