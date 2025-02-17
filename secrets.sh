#!/usr/bin/env bash

ENV_FILE=".env"

echo "Setting up secrets for your project..."

# Ensure .env exists
if [ ! -f "$ENV_FILE" ]; then
    touch "$ENV_FILE"
    echo "# Environment variables (ignored by Git)" >> "$ENV_FILE"
fi

# Function to prompt for secrets
set_secret() {
    local key="$1"

    # Check if the secret already exists in the .env file
    if grep -q "^$key=" "$ENV_FILE"; then
        echo "󰄲 $key already set. Skipping..."
    else
        read -p "󰄱 Enter value for $key: " value
        tput cuu1 && tput el
        echo "$key=$value" >> "$ENV_FILE"
        echo "󰄲 $key added to $ENV_FILE."
    fi
}

# List of secrets to ask for
SECRETS=("CLOUDFLARE_EMAIL" "CLOUDFLARE_API_KEY" "ZONE_ID")

# Loop through and set each secret
for secret in "${SECRETS[@]}"; do
    set_secret "$secret"
done

# Ensure .env is ignored by Git
if ! grep -q "^.env$" .gitignore; then
    echo ".env" >> .gitignore
    echo ".env added to .gitignore."
fi

echo "󰄭 Secrets setup complete! Use 'direnv allow' to reload your environment."

