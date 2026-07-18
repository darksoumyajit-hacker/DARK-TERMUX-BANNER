#!/data/data/com.termux/files/usr/bin/bash

# DARK-SOUMYA Uninstaller
# Created by @soumyajit
# Version 1.0.0

# Load colors if available
if [ -f "./colors.sh" ]; then
    source ./colors.sh
else
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    NC='\033[0m'
fi

# Global variables
USER_HOME="/data/data/com.termux/files/home"
BANNER_DIR="$USER_HOME/.darksoumya"
BACKUP_DIR="$USER_HOME/.darksoumya_backup"
OLD_BASHRC="$USER_HOME/.bashrc"
BASHRC_BACKUP="$BACKUP_DIR/.bashrc.backup"

# Function to display header
display_header() {
    clear
    echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${YELLOW}          DARK-SOUMYA Uninstaller                       ${RED}║${NC}"
    echo -e "${RED}║${CYAN}              Created by @soumyajit                   ${RED}║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Function to check if DARK-SOUMYA is installed
check_installation() {
    if [ ! -d "$BANNER_DIR" ]; then
        echo -e "${RED}[!] DARK-SOUMYA is not installed!${NC}"
        exit 1
    fi
}

# Function to confirm uninstallation
confirm_uninstall() {
    echo -e "${YELLOW}[!] This will remove DARK-SOUMYA from your system.${NC}"
    echo -e "${YELLOW}[!] Your .bashrc will be restored if a backup exists.${NC}"
    echo ""
    echo -n "Do you want to continue? (y/n): "
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}[✓] Uninstallation cancelled.${NC}"
        exit 0
    fi
}

# Function to remove DARK-SOUMYA files
remove_files() {
    echo -e "${BLUE}[*] Removing DARK-SOUMYA files...${NC}"
    
    if [ -d "$BANNER_DIR" ]; then
        rm -rf "$BANNER_DIR"
        echo -e "${GREEN}[✓] Banner directory removed${NC}"
    fi
    
    sleep 1
}

# Function to restore .bashrc
restore_bashrc() {
    echo -e "${BLUE}[*] Restoring .bashrc...${NC}"
    
    # Remove DARK-SOUMYA lines from .bashrc
    if [ -f "$OLD_BASHRC" ]; then
        sed -i '/# DARK-SOUMYA Banner/d' "$OLD_BASHRC"
        sed -i '/if \[ -f ~\/.darksoumya\/display.sh \]; then/d' "$OLD_BASHRC"
        sed -i '/    ~\/.darksoumya\/display.sh/d' "$OLD_BASHRC"
        sed -i '/fi/d' "$OLD_BASHRC"
        
        echo -e "${GREEN}[✓] DARK-SOUMYA removed from .bashrc${NC}"
    fi
    
    # Restore backup if exists
    if [ -f "$BASHRC_BACKUP" ]; then
        cp "$BASHRC_BACKUP" "$OLD_BASHRC"
        echo -e "${GREEN}[✓] .bashrc restored from backup${NC}"
    fi
    
    sleep 1
}

# Function to remove backup directory
cleanup_backup() {
    echo -e "${BLUE}[*] Cleaning up...${NC}"
    
    if [ -d "$BACKUP_DIR" ]; then
        read -p "Remove backup directory? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$BACKUP_DIR"
            echo -e "${GREEN}[✓] Backup directory removed${NC}"
        else
            echo -e "${YELLOW}[!] Backup directory kept at $BACKUP_DIR${NC}"
        fi
    fi
    
    sleep 1
}

# Function to display success message
success_screen() {
    clear
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${YELLOW}          DARK-SOUMYA Uninstalled Successfully!        ${GREEN}║${NC}"
    echo -e "${GREEN}║${CYAN}              Thanks for using DARK-SOUMYA               ${GREEN}║${NC}"
    echo -e "${GREEN}║${BLUE}              Created by @soumyajit                   ${GREEN}║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}Restart Termux to see the changes.${NC}"
    echo ""
}

# Main function
main() {
    display_header
    check_installation
    confirm_uninstall
    
    echo -e "${BLUE}[*] Starting uninstallation of DARK-SOUMYA...${NC}"
    sleep 1
    
    remove_files
    restore_bashrc
    cleanup_backup
    
    success_screen
}

# Error handling
trap 'echo -e "${RED}[!] Uninstallation interrupted.${NC}"; exit 1' INT TERM

# Run main
main
