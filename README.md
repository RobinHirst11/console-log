# Discord Log Notifier

**Share your command's console output directly in Discord.**

This script runs any command you specify and sends the **entire console output** (both standard output and standard error) to a Discord channel, regardless of whether the command succeeds or fails. This is particularly useful for collaborative development or debugging when you need to share console output with your team on Discord.

## Usage

1. **Set up a Discord webhook:** Go to your server settings, create a webhook in the desired channel, and copy the webhook URL.
2. **Configure the script:** Replace `YOUR_DISCORD_WEBHOOK_URL` in `send-discord-log.sh` with your webhook URL.
3. **Run the script:**

   ```bash
   ./send-discord-log.sh your_command your_arguments
   ```

**Example:**

```bash
./send-discord-log.sh ./my_script.sh arg1 arg2
```

This will run `my_script.sh` and send its entire console output to your Discord channel, whether it succeeds or fails.

## Customization

- **Message format:** You can customize the message structure (e.g., add timestamps, user information) by editing the `echo` commands within the script.

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## License

MIT License. See the [LICENSE](LICENSE) file for details. 
