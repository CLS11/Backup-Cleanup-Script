#!/bin/bash

#Variables
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
MAX_BACKUPS=5

#Create backup directory
mkdir -p "$BACKUP_DIR"

#Create backup
echo "Creating backup of $SOURCE_DIR..."
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"
echo "Backup created: $BACKUP_FILE"

#List backups
echo ""
echo "Current backups:"
ls -lh "$BACKUP_DIR"/*.tar.gz

#Delete old backups if more than MAX_BACKUPS
COUNT=$(ls -1 "$BACKUP_DIR"/*.tar.gz | wc -l)
if [ "$COUNT" -gt "$MAX_BACKUPS" ]; then
	OLDEST=$(ls -t "$BACKUP_DIR"/*.tar.gz | tail -1)
	echo ""
	echo "Removing oldest backup: $OLDEST"
	rm -f "$OLDEST"
fi

echo ""
echo "Backup process complete."

