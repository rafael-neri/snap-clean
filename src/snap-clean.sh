#!/bin/bash
set -eu

# Function to log messages
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

# Function to remove disabled snap revisions
remove_disabled_snaps() {
    log "Starting to remove disabled snap revisions"
    snap list --all | awk '/disabled/{print $1, $3}' |
    while read -r snapname revision; do
        log "Removing $snapname revision $revision"
        sudo snap remove "$snapname" --revision="$revision" || {
            log "Failed to remove $snapname revision $revision"
            exit 1
        }
    done
    log "Finished removing disabled snap revisions"
}

# Main script execution
remove_disabled_snaps
