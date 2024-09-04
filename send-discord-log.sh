#!/bin/sh -u

# Script to send command logs to Discord if the command fails.

# --- User Configuration ---
DISCORD_WEBHOOK_URL="YOUR_DISCORD_WEBHOOK_URL" # Replace with your actual webhook URL
# ------------------------

# Use command as task name
TASK_NAME="$1"
GREP_LINES="^\W|^Fail|^Skip"

# Create temporary files
MSG_FILE=$(mktemp)
LOG_FILE=$(mktemp)

# Delete temporary files on exit
function cleanup {
    rm "$LOG_FILE" "$MSG_FILE"
}
trap cleanup EXIT

# Redirect all output to /dev/null (silent execution)
exec 1>/dev/null 2>&1

# Run command and capture console output
(time "$@") > "$LOG_FILE" 2>&1

# Determine status based on command exit code
if [ $? -eq 0 ]; then
    STATUS="OK"
else
    STATUS="FAILURE"
fi

# Construct message for Discord
echo '```' >> "$MSG_FILE"
echo "
$STATUS | $@
----------------------------------------
$(egrep "$GREP_LINES" "$LOG_FILE")
" | head -c 1990 >> "$MSG_FILE" # Limit message length to avoid Discord limits
echo '```' >> "$MSG_FILE"

# Post to Discord
curl \
    --form "username=$TASK_NAME" \
    --form "content=<$MSG_FILE" \
    --form "file=@$LOG_FILE;type=text/plain;filename=$TASK_NAME.log" \
    "$DISCORD_WEBHOOK_URL"
