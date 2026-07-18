#!/data/data/com.termux/files/usr/bin/bash

# DARK-SOUMYA Banner Display Script
# Created by @soumyajit
# Version 1.0.0

# Load colors
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/colors.sh" ]; then
    source "$SCRIPT_DIR/colors.sh"
else
    # Fallback colors if colors.sh is not found
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m'
fi

# Get theme from config
THEME_FILE="$HOME/.darksoumya/theme.conf"
if [ -f "$THEME_FILE" ]; then
    THEME=$(cat "$THEME_FILE")
else
    THEME=1
fi

# Function to display banner with theme
display_banner() {
    local banner_file="$HOME/.darksoumya/banner.txt"
    
    if [ -f "$banner_file" ]; then
        case $THEME in
            1) # Default
                echo -e "${GREEN}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${BLUE}║${GREEN}          Welcome to DARK-SOUMYA Termux               ${BLUE}║${NC}"
                echo -e "${BLUE}║${CYAN}              Created by @soumyajit                   ${BLUE}║${NC}"
                echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
            2) # Cyber
                echo -e "${CYAN}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${PURPLE}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${PURPLE}║${CYAN}          Welcome to DARK-SOUMYA Cyber Edition       ${PURPLE}║${NC}"
                echo -e "${PURPLE}║${YELLOW}              Created by @soumyajit                 ${PURPLE}║${NC}"
                echo -e "${PURPLE}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
            3) # Sunset
                echo -e "${RED}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${YELLOW}║${RED}          Welcome to DARK-SOUMYA Sunset Edition       ${YELLOW}║${NC}"
                echo -e "${YELLOW}║${ORANGE}              Created by @soumyajit                 ${YELLOW}║${NC}"
                echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
            4) # Ice
                echo -e "${BLUE}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${WHITE}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${WHITE}║${BLUE}          Welcome to DARK-SOUMYA Ice Edition         ${WHITE}║${NC}"
                echo -e "${WHITE}║${CYAN}              Created by @soumyajit                   ${WHITE}║${NC}"
                echo -e "${WHITE}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
            5) # Matrix
                echo -e "${GREEN}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${BLACK}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${BLACK}║${GREEN}          Welcome to DARK-SOUMYA Matrix Edition      ${BLACK}║${NC}"
                echo -e "${BLACK}║${LIME}              Created by @soumyajit                   ${BLACK}║${NC}"
                echo -e "${BLACK}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
            *)
                echo -e "${GREEN}"
                cat "$banner_file"
                echo -e "${NC}"
                echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
                echo -e "${BLUE}║${GREEN}          Welcome to DARK-SOUMYA Termux               ${BLUE}║${NC}"
                echo -e "${BLUE}║${CYAN}              Created by @soumyajit                   ${BLUE}║${NC}"
                echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
                ;;
        esac
    else
        echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║${YELLOW}          DARK-SOUMYA Banner Not Found!                  ${RED}║${NC}"
        echo -e "${RED}║${CYAN}              Created by @soumyajit                   ${RED}║${NC}"
        echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    fi
}

# Display system info
display_system_info() {
    echo ""
    echo -e "${BLUE}System Information:${NC}"
    echo -e "${CYAN}├─${WHITE} Date: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo -e "${CYAN}├─${WHITE} User: $(whoami)${NC}"
    echo -e "${CYAN}└─${WHITE} Termux: $(pkg list-installed 2>/dev/null | wc -l) packages installed${NC}"
    echo ""
}

# Main display
main() {
    clear
    display_banner
    display_system_info
}

# Run main
main
