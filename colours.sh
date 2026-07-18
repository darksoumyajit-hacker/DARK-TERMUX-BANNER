#!/data/data/com.termux/files/usr/bin/bash

# DARK-SOUMYA Color Definitions
# Created by @soumyajit
# Version 1.0.0

# Reset
export NC='\033[0m'

# Regular Colors
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'

# Bold
export BBLACK='\033[1;30m'
export BRED='\033[1;31m'
export BGREEN='\033[1;32m'
export BYELLOW='\033[1;33m'
export BBLUE='\033[1;34m'
export BPURPLE='\033[1;35m'
export BCYAN='\033[1;36m'
export BWHITE='\033[1;37m'

# Underline
export UBLACK='\033[4;30m'
export URED='\033[4;31m'
export UGREEN='\033[4;32m'
export UYELLOW='\033[4;33m'
export UBLUE='\033[4;34m'
export UPURPLE='\033[4;35m'
export UCYAN='\033[4;36m'
export UWHITE='\033[4;37m'

# Background
export BG_BLACK='\033[40m'
export BG_RED='\033[41m'
export BG_GREEN='\033[42m'
export BG_YELLOW='\033[43m'
export BG_BLUE='\033[44m'
export BG_PURPLE='\033[45m'
export BG_CYAN='\033[46m'
export BG_WHITE='\033[47m'

# High Intensity
export IBLACK='\033[0;90m'
export IRED='\033[0;91m'
export IGREEN='\033[0;92m'
export IYELLOW='\033[0;93m'
export IBLUE='\033[0;94m'
export IPURPLE='\033[0;95m'
export ICYAN='\033[0;96m'
export IWHITE='\033[0;97m'

# Bold High Intensity
export BIBLACK='\033[1;90m'
export BIRED='\033[1;91m'
export BIGREEN='\033[1;92m'
export BIYELLOW='\033[1;93m'
export BIBLUE='\033[1;94m'
export BIPURPLE='\033[1;95m'
export BICYAN='\033[1;96m'
export BIWHITE='\033[1;97m'

# Background High Intensity
export BG_IBLACK='\033[0;100m'
export BG_IRED='\033[0;101m'
export BG_IGREEN='\033[0;102m'
export BG_IYELLOW='\033[0;103m'
export BG_IBLUE='\033[0;104m'
export BG_IPURPLE='\033[0;105m'
export BG_ICYAN='\033[0;106m'
export BG_IWHITE='\033[0;107m'

# Additional colors
export ORANGE='\033[38;5;208m'
export LIME='\033[38;5;154m'
export PINK='\033[38;5;213m'
export GOLD='\033[38;5;220m'

# Reset all
export RESET='\033[0m'

# Function to print colored text
print_color() {
    local color=$1
    local text=$2
    echo -e "${color}${text}${NC}"
}

# Function to print colored text with newline
print_color_n() {
    local color=$1
    local text=$2
    echo -ne "${color}${text}${NC}"
}

# Function to get theme colors
get_theme_colors() {
    local theme=$1
    case $theme in
        1) # Default
            PRIMARY="$GREEN"
            SECONDARY="$BLUE"
            ACCENT="$CYAN"
            ;;
        2) # Cyber
            PRIMARY="$CYAN"
            SECONDARY="$PURPLE"
            ACCENT="$PINK"
            ;;
        3) # Sunset
            PRIMARY="$RED"
            SECONDARY="$ORANGE"
            ACCENT="$YELLOW"
            ;;
        4) # Ice
            PRIMARY="$BLUE"
            SECONDARY="$WHITE"
            ACCENT="$CYAN"
            ;;
        5) # Matrix
            PRIMARY="$GREEN"
            SECONDARY="$LIME"
            ACCENT="$BLACK"
            ;;
        *)
            PRIMARY="$GREEN"
            SECONDARY="$BLUE"
            ACCENT="$CYAN"
            ;;
    esac
}
