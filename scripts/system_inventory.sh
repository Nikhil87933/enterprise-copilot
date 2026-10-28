#!/usr/bin/env bash

set -u

section() {
    printf '\n=== %s ===\n' "$1"
}

check_command() {
    local command_name="$1"
    local version_args="${2:---version}"

    if command -v "$command_name" >/dev/null 2>&1; then
        "$command_name" $version_args 2>&1 | head -n 1
    else
        printf 'Not installed or unavailable\n'
    fi
}

printf 'Enterprise Copilot - Development Environment Inventory\n'
printf 'Generated: %s\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')"

section "Operating System"

if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    printf 'Distribution: %s\n' "${NAME:-Unknown}"
    printf 'Version: %s\n' "${VERSION_ID:-Unknown}"
else
    printf 'OS release information unavailable\n'
fi

printf 'Kernel: %s\n' "$(uname -r)"
printf 'Architecture: %s\n' "$(uname -m)"

section "CPU"

if command -v lscpu >/dev/null 2>&1; then
    lscpu | awk -F: '
        /^Model name:/ {gsub(/^[ \t]+/, "", $2); print "Model: " $2}
        /^CPU\(s\):/ {gsub(/^[ \t]+/, "", $2); print "Logical CPUs: " $2; exit}
    '
else
    printf 'CPU details unavailable\n'
fi

section "Memory"

if command -v free >/dev/null 2>&1; then
    free -h | awk '
        /^Mem:/  {print "Total RAM: " $2}
        /^Swap:/ {print "Total swap: " $2}
    '
else
    printf 'Memory information unavailable\n'
fi

section "Project Filesystem"

df -h . | awk 'NR == 1 {print "Filesystem capacity:"; print}'

section "Python"

if command -v python3 >/dev/null 2>&1; then
    python3 --version 2>&1
else
    printf 'Python 3 is not installed or unavailable\n'
fi

section "Git"

check_command git

if command -v git >/dev/null 2>&1; then
    if [[ -n "$(git config --get user.name 2>/dev/null || true)" ]]; then
        printf 'Commit author name: configured\n'
    else
        printf 'Commit author name: not configured\n'
    fi

    if [[ -n "$(git config --get user.email 2>/dev/null || true)" ]]; then
        printf 'Commit author email: configured\n'
    else
        printf 'Commit author email: not configured\n'
    fi
fi

section "Visual Studio Code"

check_command code

section "Docker"

check_command docker

section "Docker Compose"

if command -v docker >/dev/null 2>&1 &&
   docker compose version >/dev/null 2>&1; then
    docker compose version 2>&1 | head -n 1
else
    printf 'Docker Compose plugin unavailable\n'
fi

printf '\nInventory collection completed.\n'
