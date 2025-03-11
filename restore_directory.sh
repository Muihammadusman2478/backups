#!/bin/bash

# Load environment variables from .duplicity
source /root/.duplicity

# Prompt user for inputs
read -p "Enter the restore date (YYYY-MM-DDT06:15:47): " restore_date
read -p "Enter the directory name to restore: " directory_to_restore
read -p "Enter the app directory name: " app_dir

# Run the duplicity restore command
duplicity restore --no-encryption --no-print-statistics --s3-use-new-style -v 4 -t "$restore_date" \
  --file-to-restore "public_html/$directory_to_restore" \
  "$(awk -F'[="]' '/S3_url/ {print $3}' /root/.duplicity)/apps/$app_dir" \
  "/home/master/applications/$app_dir/tmp/$directory_to_restore"

# Echo the restored directory location
echo "The directory has been restored to: /home/master/applications/$app_dir/tmp/$directory_to_restore"
