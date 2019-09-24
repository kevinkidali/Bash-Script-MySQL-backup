### Bash-Script-MySQL-backup
- Simple bash script for backing up your database.
- To automatically back up your database periodically, attach the script to crontab.
- The script also sends your database back ups to a remote repository that you will set.

### Running script manually
- In your terminal execute: `./db-backup.sh` or `ssh db-backup.sh`

### Automatically running the script
- Crontab -e `/bin/sh ${DIRECTORY_PATH}/Bash-Script-MySQL-backup/db-backup.sh >> /tmp/db-backup-logs 2>&1`

### If file doesn't execute
- Give it permission `chmod +x db-backup.sh`

### Tip
- Combine git commands; add & commit: `git config --global alias.add-commit '!git add -A && git commit'`
