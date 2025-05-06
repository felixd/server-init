#!/bin/bash

# Array of SSH keys
ssh_keys=(
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAEHbtCr6gO2fvELCP3tN7opQ4YUpEKsU/MxqJMJIz+VVlJQ6uiq1Lm2HDgU45SM1AhKASMmWnKm4tPCcTwzvPd4MwAuReslHE/ahtNNBnbjGu90nLe7SVn1aytaeKC2rYo8XH5/xa1hOpzBG7Zj6Qp/ihjuWkVIPwS/rZBUvdjtlk9oFQ== felixd-GPG"
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBHEmnlM6yvgEx49xFjZPchL5/elqHL5ojqehcObLFqSKBHYrYklyPvA5z0jYV54GmFJ5ZxWHpe+jQr/sw9i2tnqvwaAKGqvX7aK06h9p9NbQ1j2JIB8r9xjou366a6ZjUA==  PKCS:ceac18fae62357cafc0f0f842b44f702bf29265b= felixd-eID-SC"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZ+JLxvk0QVurxFXUgssEvzWTQTxYUzMKxxR0l+AMI3i4T633Hx9PB5Q8Lf526iaoSNTfcU3EJ8J/CHbi8jDfmFeVjB17XAo3G8cdTPrvDJRjzpUM66o8vgryumwUjYC5rYlF+Qn5WXnKut5hSXtHHMvfVy2EavtCvvvLUkgIddzH+3faclugI4zlOskXdt+TeUYG+fuLXAKePW4TqUx67iNGcBKg8c83TWmfX4R1e7M7+gz03cqfdK6LzfXVK+keRygeHdohfAcwbhFZjmvY/AR+3lFAGAwUwIemXiuM/8728qa7rHTVgGkbMhowx7a55TcaUURYjl58QgyGw2/XUmjnAjk4veKf0H8TjMS05Sag/vcpi0rM0qDgUfXElEtmzEYUGpgYCVTm6MjgYqnnjIfrJssLRRUMnDLCivxEi5a8K3Vt73iv9Z/LVzQnftEFSeohC4fZpxGhjiQje/G9gVButMzARwii0JUYuYLXZEssfc/Q3oMqwkGRkcSqNaYE= felixd@sur10-ser-dl360-gen9-1"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIObGx+p6XO+X49dxjCjNNpfV/HC99FP7+MmsrYpTOyLh felixd@felixd-ilogic-terminal"
    # Add more keys as needed
)

ssh_folder="$HOME/.ssh"
authorized_keys_file="$ssh_folder/authorized_keys"

# Check if the .ssh folder exists or create it if it doesn't
if [ ! -d "$ssh_folder" ]; then
    echo "Creating .ssh folder: $ssh_folder"
    mkdir -p "$ssh_folder"
    chmod 700 "$ssh_folder"
fi

# Check and append SSH keys
for key in "${ssh_keys[@]}"; do
    if ! grep -qF "$key" "$authorized_keys_file"; then
        echo "Adding the key: $key"
        echo "$key" >> "$authorized_keys_file"
    else
        echo "Key already exists: $key"
    fi
done

if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "debian" || $ID == "ubuntu" ]]; then
        echo "This is a Debian-based distribution."
        # You can now use 'apt' to install apps.
        sudo apt update 
        sudo apt upgrade -y
        sudo apt install chrony mc gpg htop btop iotop iperf3 tcpdump screen -y

        # TODO: RNG Seed to make sure that server is properly seeded
        echo "Soon to be added RNG Seed"

    else
        echo "This is not a Debian-based distribution."
        exit 0
    fi
else
    echo "Unable to determine the distribution type."
fi
