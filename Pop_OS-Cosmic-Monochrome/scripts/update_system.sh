#!/bin/bash
set -eo pipefail

# ─────────────────────────────────────────────
#  Monochrome Dark palette
#  bg:      #111111   fg:      #828282
#  primary: #aaaaaa   secondary:#a7a7a7
#  border:  #bdbdbd   success: #cccccc
#  warning: #aaaaaa   error:   #dddddd
#  dim:     #636363
# ─────────────────────────────────────────────

# Monochrome Dark — using $'...' so escape bytes are stored at assignment time
# and work correctly with both echo -e and printf "%s"
CYAN=$'\033[38;2;189;189;189m'    # #bdbdbd  – section headers
BLUE=$'\033[38;2;167;167;167m'    # #a7a7a7  – info / commands
PURPLE=$'\033[38;2;204;204;204m'  # #cccccc  – highlights
GREEN=$'\033[38;2;204;204;204m'   # #cccccc  – success
YELLOW=$'\033[38;2;170;170;170m'  # #aaaaaa  – warnings
ORANGE=$'\033[38;2;130;130;130m'  # #828282  – skipped
RED=$'\033[38;2;221;221;221m'     # #dddddd  – errors
DIM=$'\033[38;2;99;99;99m'        # #636363  – comments / dim text
BOLD=$'\033[1m'
RESET=$'\033[0m'

# ── Helpers ────────────────────────────────────────────────────────────────────

print_header() {
    echo
    echo -e "${CYAN}${BOLD}┌─ $1 ${DIM}──────────────────────────────────────${RESET}"
}

print_success() { echo -e "  ${GREEN}✓ $1${RESET}"; }
print_info()    { echo -e "  ${BLUE}→ $1${RESET}"; }
print_warn()    { echo -e "  ${YELLOW}⚠ $1${RESET}"; }
print_skip()    { echo -e "  ${ORANGE}⊘ $1${RESET}"; }
print_error()   { echo -e "  ${RED}✗ $1${RESET}"; }
print_dim()     { echo -e "  ${DIM}$1${RESET}"; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

# ── Config ─────────────────────────────────────────────────────────────────────

# Phased updates: Ubuntu staggers non-security updates so a bad one only hits a
# fraction of machines first. Setting this to "true" opts out of that — you pull
# every update immediately and become an early tester. Security updates are never
# phased, so they always install regardless of this setting.
#   true  = always pull phased updates now (early-adopter)
#   false = honor the rollout, install when it reaches you (safer default)
INCLUDE_PHASED=true

# Built once and passed to apt/nala. Empty when INCLUDE_PHASED=false.
PHASED_OPT=()
if [ "$INCLUDE_PHASED" = true ]; then
    PHASED_OPT=(-o APT::Get::Always-Include-Phased-Updates=true)
fi

# ── Update functions ───────────────────────────────────────────────────────────

update_system() {
    print_header "System Packages"

    if [ "$INCLUDE_PHASED" = true ]; then
        print_dim "Including phased updates (early-adopter mode)"
    fi

    if command_exists nala; then
        print_info "Package manager: nala"
        sudo nala update
        sudo nala upgrade --full -y "${PHASED_OPT[@]}"
#        sudo nala autoremove -y
        sudo nala clean
        print_success "Nala system update complete"

    elif command_exists apt; then
        print_info "Package manager: apt (nala not found)"
        sudo apt update
        sudo apt full-upgrade -y "${PHASED_OPT[@]}"
#        sudo apt autoremove -y
        sudo apt autoclean
        print_success "APT system update complete"

    else
        print_error "No supported package manager found — skipping"
        return 1
    fi
}

update_flatpak() {
    print_header "Flatpak"
    if ! command_exists flatpak; then
        print_skip "Flatpak not installed — skipping"
        return 0
    fi

    print_info "Running flatpak update..."
    if flatpak update -y; then
        print_success "Flatpak updates applied"
    else
        print_warn "Flatpak finished with some warnings"
    fi
}

update_snap() {
    print_header "Snap"

    if ! command_exists snap; then
        print_skip "Snap not installed — skipping"
        return 0
    fi

    print_info "Running snap refresh..."
    local output
    output=$(sudo snap refresh 2>&1) || true
    while IFS= read -r line; do
        echo -e "  ${DIM}${line}${RESET}"
    done <<< "$output"

    if echo "$output" | grep -q "All snaps up to date"; then
        print_success "All snaps are already up to date"
    else
        print_success "Snap updates applied"
    fi
}

# ── Logo ───────────────────────────────────────────────────────────────────────

# Monochrome logo accents — global scope so $'...' escapes work correctly
TEAL=$'\033[38;2;170;170;170m'   # #aaaaaa  primary gray
ORG=$'\033[38;2;189;189;189m'    # #bdbdbd  border gray

# Banner rows, ANSI Shadow figlet font. All 46 columns wide; keep them that way
# or the gradient below will drift out of alignment with the letterforms.
LOGO_ROWS=(
    ' ██████╗ ██╗  ██╗██████╗ ███████╗██╗   ██╗ ██╗'
    '██╔═████╗╚██╗██╔╝██╔══██╗██╔════╝██║   ██║███║'
    '██║██╔██║ ╚███╔╝ ██║  ██║█████╗  ██║   ██║╚██║'
    '████╔╝██║ ██╔██╗ ██║  ██║██╔══╝  ╚██╗ ██╔╝ ██║'
    '╚██████╔╝██╔╝ ██╗██████╔╝███████╗ ╚████╔╝  ██║'
    ' ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝  ╚═══╝   ╚═╝'
)

# Per-column colours for the banner: mid gray → light gray.
# Same 46 columns as before; every channel is equal so there is no hue.
# One entry per column, 46 total.
LOGO_GRAD=(
    "122;122;122" "124;124;124" "126;126;126" "128;128;128" "130;130;130" "132;132;132"
    "134;134;134" "136;136;136" "138;138;138" "139;139;139" "141;141;141" "143;143;143"
    "145;145;145" "147;147;147" "149;149;149" "151;151;151" "153;153;153" "155;155;155"
    "157;157;157" "159;159;159" "160;160;160" "162;162;162" "164;164;164" "166;166;166"
    "168;168;168" "170;170;170" "172;172;172" "174;174;174" "176;176;176" "178;178;178"
    "180;180;180" "182;182;182" "183;183;183" "185;185;185" "187;187;187" "189;189;189"
    "191;191;191" "193;193;193" "195;195;195" "197;197;197" "199;199;199" "201;201;201"
    "203;203;203" "205;205;205" "207;207;207" "210;210;210"
)

# Draw the banner one character at a time, colouring by column index so the
# gradient runs horizontally across the whole word. Every glyph gets the ramp,
# including the box-drawing bevel characters (╔ ═ ╗ ║ ╚ ╝) — colouring those
# separately puts stray marks inside the 0, the D bowl and the e, which reads
# as noise sitting on top of the letters rather than as depth.
print_logo() {
    # figlet rows are multibyte; force a UTF-8 locale so ${row:i:1} steps by
    # character instead of by byte. Local to this function only.
    local LC_ALL=C.UTF-8
    local row ch out i

    echo
    for row in "${LOGO_ROWS[@]}"; do
        out=""
        for (( i = 0; i < ${#row}; i++ )); do
            ch="${row:i:1}"
            if [ "$ch" = " " ]; then
                out+=" "
            else
                out+=$'\033[1;38;2;'"${LOGO_GRAD[i]}"$'m'"$ch"
            fi
        done
        printf '  %s%s\n' "$out" "$RESET"
    done

    echo
    printf "  ${TEAL}━━━━━━━━━━━━━━━━━━━━━━━${ORG}━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
    printf "  ${DIM}  Pop!_OS · COSMIC DE · System Update${RESET}\n"
    printf "  ${DIM}  %s${RESET}\n" "$(date '+%A %d %B %Y  %H:%M:%S')"
    echo
}

# ── Main ───────────────────────────────────────────────────────────────────────

main() {
    local start_time end_time duration

    print_logo

    start_time=$(date +%s)

    update_system || {
        print_error "System package update failed — continuing with remaining tasks"
    }

    update_flatpak
#    update_snap

    end_time=$(date +%s)
    duration=$((end_time - start_time))

    echo
    echo -e "${CYAN}${BOLD}└─ All done ${DIM}──────────────────────────────────${RESET}"
    printf "   ${GREEN}✓ Completed in ${BOLD}%dm %ds${RESET}\n" \
        $((duration / 60)) $((duration % 60))
    echo
}

main
