#!/bin/bash
RAMDISK="/mnt/ramdisk"
BACKUP_DIR="/var/ramdisk-backup"

case "$1" in
    start)
        # Create backup directory on disk if it doesn't exist
        mkdir -p "$BACKUP_DIR"
        # Sync from disk back into RAMDISK if a backup exists
        if [ "$(ls -A $BACKUP_DIR)" ]; then
            rsync -aX --inplace "$BACKUP_DIR/" "$RAMDISK/"
        fi
        ;;
    stop)
        # DIAGNOSTIC TRAP: Log what is actually mounted at shutdown
        echo "=== SHUTDOWN MOUNT STATE ===" > /var/tmpfs_shutdown_debug.log 2>&1
        mount | grep -E 'tmpfs|/var' >> /var/tmpfs_shutdown_debug.log 2>&1
        ls -la "$RAMDISK" >> /var/tmpfs_shutdown_debug.log 2>&1
        mkdir -p "$BACKUP_DIR"
        rsync -aX --delete --inplace --no-whole-file --update "$RAMDISK/" "$BACKUP_DIR/" >> /var/tmpfs_shutdown_debug.log 2>&1
        ;;
esac
