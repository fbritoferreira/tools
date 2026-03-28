# tools

Personal CLI tools. Install to `~/bin` with:

```bash
./install.sh
```

## bw-fetch-secrets

Fetches secrets from Bitwarden Personal Vault and caches them as shell environment variables.

### Prerequisites

- [Bitwarden CLI](https://bitwarden.com/help/cli/) (`brew install bitwarden-cli`)
- `jq` (`brew install jq`)
- macOS Keychain (for storing master password)

### Setup

1. Log in to Bitwarden: `bw login`
2. Store your master password in Keychain:
   ```bash
   security add-generic-password -a "$(whoami)" -s "bw-master-password" -w -U
   ```
3. Create a Bitwarden vault item named **"Shell Secrets"** with custom fields for each env var you want exported (use Hidden field type).

4. Add to your `~/.zshrc`:
   ```zsh
   [[ -f "${HOME}/.cache/bw-env" ]] && source "${HOME}/.cache/bw-env"

   refresh-secrets() {
     "${HOME}/bin/bw-fetch-secrets" && source "${HOME}/.cache/bw-env" && echo "Secrets refreshed in current shell."
   }
   ```

### Usage

```bash
bw-fetch-secrets          # fetch secrets and write cache
bw-fetch-secrets --check  # check if cache is fresh (<24h)
refresh-secrets           # fetch + reload in current shell
```

The cache is written to `~/.cache/bw-env` with `600` permissions.

If a `RAYCAST_TOKEN` field exists, the script also regenerates `~/.config/raycast/config.json`.

## tf

Terraform wrapper that sources a local `.env` file before running `terraform`.

```bash
tf plan
tf apply
```
