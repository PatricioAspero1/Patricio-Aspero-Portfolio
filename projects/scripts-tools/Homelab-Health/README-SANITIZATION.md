# Public Script Sanitization Notes

These versions are intended for a public portfolio repository.

Before using them in a real environment:

1. Store API keys, webhook URLs, hostnames, and other environment-specific values outside the scripts.
2. Load those values from a private environment file or secret manager.
3. Never commit real `.env` files, API keys, Discord webhooks, passwords, SSH private keys, or VPN keys.
4. Prefer managed SSH host keys instead of disabling `StrictHostKeyChecking`.
5. Limit `sudo` permissions for the automation account to only the commands it needs.
6. Review the `CRITICAL_CTS` list before enabling automatic restarts.
7. Test recovery actions on non-critical workloads first.

The `.env.example` file contains placeholders only and is safe to publish.
