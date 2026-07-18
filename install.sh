#!/data/data/com.termux/files/usr/bin/bash

# DARK-SOUMYA Banner Installer
# Created by @soumyajit
# Version 1.0.0

# Load colors
source ./colors.sh

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="/data/data/com.termux/files/home"
BACKUP_DIR="$USER_HOME/.darksoumya_backup"
BANNER_DIR="$USER_HOME/.darksoumya"
OLD_BASHRC="$USER_HOME/.bashrc"
BASHRC_BACKUP="$BACKUP_DIR/.bashrc.backup"
SELECTED_BANNER=""
THEME_CHOICE=""

# Function to display loading animation
loading_animation() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    echo -ne "${YELLOW}Loading DARK-SOUMYA "
    while ps -p $pid > /dev/null 2>&1; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    echo -e "${GREEN} Done!${NC}"
}

# Function to display animated progress bar
progress_bar() {
    local duration=$1
    local steps=20
    local sleep_time=$(echo "$duration / $steps" | bc -l)
    
    echo -ne "${CYAN}["
    for ((i=0; i<=steps; i++)); do
        local progress=$((i * 100 / steps))
        local filled=$((i * 50 / steps))
        local empty=$((50 - filled))
        
        printf "\r["
        printf "%${filled}s" | tr ' ' '='
        printf "%${empty}s" | tr ' ' ' '
        printf "] %d%%" "$progress"
        sleep "$sleep_time"
    done
    echo -e "${NC}"
}

# Function to display welcome screen
welcome_screen() {
    clear
    echo -e "${CYAN}"
    cat "$SCRIPT_DIR/ascii/darksoumya.txt"
    echo -e "${NC}"
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${GREEN}          Welcome to DARK-SOUMYA Banner Installer        ${YELLOW}║${NC}"
    echo -e "${YELLOW}║${BLUE}               Created by @soumyajit                      ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}DARK-SOUMYA will customize your Termux with style!${NC}"
    echo ""
}

# Function to check Termux environment
check_environment() {
    echo -e "${BLUE}[*] Checking environment...${NC}"
    
    if [ ! -d "/data/data/com.termux" ]; then
        echo -e "${RED}[!] This script must be run in Termux!${NC}"
        exit 1
    fi
    
    if [ ! -f "$USER_HOME/.bashrc" ]; then
        echo -e "${YELLOW}[!] .bashrc not found. Creating one...${NC}"
        touch "$USER_HOME/.bashrc"
    fi
    
    echo -e "${GREEN}[✓] Environment check passed!${NC}"
    sleep 1
}

# Function to backup existing .bashrc
backup_bashrc() {
    echo -e "${BLUE}[*] Backing up existing .bashrc...${NC}"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
    fi
    
    if [ -f "$OLD_BASHRC" ]; then
        cp "$OLD_BASHRC" "$BASHRC_BACKUP"
        echo -e "${GREEN}[✓] .bashrc backed up to $BASHRC_BACKUP${NC}"
    else
        echo -e "${YELLOW}[!] No .bashrc found to backup${NC}"
    fi
    sleep 1
}

# Function to select banner style
select_banner() {
    echo -e "${BLUE}[*] Select banner style:${NC}"
    echo ""
    echo -e "${YELLOW}1)${NC} DARK-SOUMYA Classic"
    echo -e "${YELLOW}2)${NC} DARK-SOUMYA Minimal"
    echo -e "${YELLOW}3)${NC} DARK-SOUMYA Glitch"
    echo -e "${YELLOW}4)${NC} DARK-SOUMYA Neon"
    echo -e "${YELLOW}5)${NC} DARK-SOUMYA Matrix"
    echo ""
    echo -n "Enter your choice (1-5): "
    read -r choice
    
    case $choice in
        1) SELECTED_BANNER="darksoumya.txt" ;;
        2) SELECTED_BANNER="logo.txt" ;;
        3) SELECTED_BANNER="glitch.txt" ;;
        4) SELECTED_BANNER="neon.txt" ;;
        5) SELECTED_BANNER="matrix.txt" ;;
        *) SELECTED_BANNER="darksoumya.txt" ;;
    esac
    
    echo -e "${GREEN}[✓] Selected banner: $SELECTED_BANNER${NC}"
    sleep 1
}

# Function to select theme
select_theme() {
    echo -e "${BLUE}[*] Select color theme:${NC}"
    echo ""
    echo -e "${YELLOW}1)${NC} Default (Green/Blue)"
    echo -e "${YELLOW}2)${NC} Cyber (Cyan/Purple)"
    echo -e "${YELLOW}3)${NC} Sunset (Red/Orange)"
    echo -e "${YELLOW}4)${NC} Ice (Blue/White)"
    echo -e "${YELLOW}5)${NC} Matrix (Green/Black)"
    echo ""
    echo -n "Enter your choice (1-5): "
    read -r choice
    
    THEME_CHOICE=$choice
    echo -e "${GREEN}[✓] Theme selected${NC}"
    sleep 1
}

# Function to preview banner
preview_banner() {
    echo -e "${BLUE}[*] Previewing banner...${NC}"
    clear
    echo -e "${CYAN}"
    if [ -f "$SCRIPT_DIR/ascii/$SELECTED_BANNER" ]; then
        cat "$SCRIPT_DIR/ascii/$SELECTED_BANNER"
    else
        echo "DARK-SOUMYA Banner Preview"
    fi
    echo -e "${NC}"
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${GREEN}                   Banner Preview                       ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}This is how your banner will look in Termux!${NC}"
    echo ""
    
    echo -n "Do you want to continue with this banner? (y/n): "
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}[!] Restarting selection...${NC}"
        sleep 1
        select_banner
        preview_banner
    fi
}

# Function to install banner
install_banner() {
    echo -e "${BLUE}[*] Installing DARK-SOUMYA banner...${NC}"
    
    # Create banner directory
    if [ ! -d "$BANNER_DIR" ]; then
        mkdir -p "$BANNER_DIR"
    fi
    
    # Copy banner files
    cp "$SCRIPT_DIR/ascii/$SELECTED_BANNER" "$BANNER_DIR/banner.txt"
    cp "$SCRIPT_DIR/colors.sh" "$BANNER_DIR/"
    cp "$SCRIPT_DIR/banner.sh" "$BANNER_DIR/"
    
    # Set theme
    echo "$THEME_CHOICE" > "$BANNER_DIR/theme.conf"
    
    # Create banner display script
    cat > "$BANNER_DIR/display.sh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
source ~/.darksoumya/colors.sh
cat ~/.darksoumya/banner.txt
echo -e "${GREEN}Welcome to DARK-SOUMYA${NC}"
echo -e "${BLUE}Created by @soumyajit${NC}"
EOF
    
    chmod +x "$BANNER_DIR/display.sh"
    
    # Add to .bashrc
    if ! grep -q "DARK-SOUMYA" "$OLD_BASHRC"; then
        echo "" >> "$OLD_BASHRC"
        echo "# DARK-SOUMYA Banner" >> "$OLD_BASHRC"
        echo "if [ -f ~/.darksoumya/display.sh ]; then" >> "$OLD_BASHRC"
        echo "    ~/.darksoumya/display.sh" >> "$OLD_BASHRC"
        echo "fi" >> "$OLD_BASHRC"
    fi
    
    echo -e "${GREEN}[✓] DARK-SOUMYA banner installed successfully!${NC}"
    sleep 1
}

# Function to display success screen
success_screen() {
    clear
    echo -e "${GREEN}"
    cat "$SCRIPT_DIR/ascii/logo.txt"
    echo -e "${NC}"
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${GREEN}          DARK-SOUMYA Installed Successfully!          ${YELLOW}║${NC}"
    echo -e "${YELLOW}║${BLUE}              Powered by DARK-SOUMYA                     ${YELLOW}║${NC}"
    echo -e "${YELLOW}║${CYAN}              Created by @soumyajit                     ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}Restart Termux to see your new banner!${NC}"
    echo -e "${CYAN}To uninstall: bash uninstall.sh${NC}"
    echo ""
}

# Main installation function
main() {
    welcome_screen
    
    # Start loading animation in background
    (
        sleep 2
    ) &
    loading_animation $!
    
    check_environment
    backup_bashrc
    
    echo -e "${BLUE}[*] Preparing DARK-SOUMYA installation...${NC}"
    progress_bar 2
    
    select_banner
    select_theme
    preview_banner
    
    echo -e "${BLUE}[*] Installing DARK-SOUMYA...${NC}"
    install_banner
    
    success_screen
}

# Error handling
trap 'echo -e "${RED}[!] Installation interrupted.${NC}"; exit 1' INT TERM

# Run main function
main
