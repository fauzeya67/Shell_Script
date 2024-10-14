#!/bin/bash

# Script to create a compressed backup of a source directory and perform backup rotation

# Arguments for Source and Backup Directories
source_dir=$1    # First argument is the source directory to back up
backup_dir=$2    # Second argument is the directory where backups will be stored
timestamp=$(date '+%d-%m-%y_%H-%M-%S')    # Timestamp for the backup file (used to make each backup unique)

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory does not exist: $source_dir"
  exit 1  # Exit with error code if the source directory is invalid
fi

# Check if the backup directory exists
if [ ! -d "$backup_dir" ]; then
  echo "Backup directory does not exist: $backup_dir"
  exit 1  # Exit with error code if the backup directory is invalid
fi

# Function to create a compressed backup
function create_backup {
  # Compress the source directory into a zip file with a timestamp in the backup directory
  zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null
  
  # Check if the zip command succeeded
  if [ $? -eq 0 ]; then
    echo "Backup created successfully at ${backup_dir}/backup_${timestamp}.zip"
    
  else
    echo "Backup failed for $timestamp"
    exit 1  # Exit with error code if the backup failed
  fi
}

# Function to perform rotation (keep only the 3 most recent backups)
function perform_rotation {
  # List all backups in the backup directory, sorted by most recent, and store them in an array
  backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
  
  # If there are more than 3 backups, remove the oldest ones
  if [ "${#backups[@]}" -gt 3 ]; then
    # Get the list of backups to remove (those after the 3rd most recent)
    backups_to_remove=("${backups[@]:3}")
    
    # Loop through the old backups and remove them
    for backup in "${backups_to_remove[@]}"; do
      rm "$backup"  # Remove the backup file
      
      # Check if the removal was successful
      if [ $? -eq 0 ]; then
        echo "Removed old backup: $backup"
      else
        echo "Failed to remove backup: $backup"
      fi
    done
  fi
}

# Call the create_backup function to perform the backup
create_backup

# Call the perform_rotation function to clean up old backups
perform_rotation
