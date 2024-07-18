!/bin/bash

echo -e "\e[33mInstalling System Updates\e[0m"
sudo apt update && sudo apt upgrade -y
sudo apt-get install figlet cowsay -y

figlet "Crypto-Genesis"

# Step 1
wait_and_display_message() {
    sleep $1
    echo -e "\e[32m$2\e[0m"
}

# Step 2
pink_space() {
    echo -e "\e[95m===============>>>>>>>>>>>>>>\e[0m"
}

# Step 3
light_blue_text() {
    echo -e "\e[1;94m$1\e[0m"
}

# Step 4
light_blue_text "**Welcome to the ZTP script developed by Crypto-Genesis for Neutaro Validator Node Installation. Let's streamline your setup process!**"

# Step 5
echo -e "\e[32m**Neutaro will install in $HOME/.Neutaro**\e[0m"

echo -e "\e[32m<Neutaro Installation in Progress>\e[0m"

wait_and_display_message 30 "Preparing Installation"

pink_space

# Step 6 
echo -e "\e[33mAdding user\e[0m"
cd $HOME
sudo chown -R $USER:$USER /home/$USER/

echo -e "\e[32mUSER added\e[0m"

pink_space

# SStep 7
echo -e "\e[33mIncreasing file limit\e[0m"
sudo sh -c 'echo "* soft nofile 65535" >> /etc/security/limits.conf'
sudo sh -c 'echo "* hard nofile 65535" >> /etc/security/limits.conf'

echo -e "\e[32mFile Limit Increased\e[0m"

pink_space

# Step 8
if ! command -v ufw &> /dev/null
then
    echo -e "\e[33mUFW is not installed. Installing...\e[0m"
    sudo apt update
    sudo apt install ufw -y
fi

# Step 9
echo -e "\e[33mAdding FW Rules\e[0m"
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 123/udp
sudo ufw allow 26656/tcp
sudo ufw --force enable <<< "yes"
sudo ufw reload
echo "UFW setup completed."
echo -e "\e[32mUFW is now configured and Enabled\e[0m"

pink_space

# Step 10
echo -e "\e[33mInstalling - Build-essential, git, make, gcc, wget, liblz4-tool and wasmlib\e[0m"

# Function to check and send Enter key if needed
send_enter_if_needed() {
    read -t 1 -n 10000 discard || return  # Check if there is any message waiting
    [ -n "$discard" ] && echo -ne '\n'  # If there's a message, send Enter key
}

# Step 11
sudo apt update && sudo apt upgrade -y
send_enter_if_needed

# Install build-essential
sudo apt install -y build-essential bsdmainutils -y
send_enter_if_needed

# Install make, gcc, wget, git and liblz4-tool
sudo apt install -y make gcc curl tar clang wget git pkg-config libssl-dev jq ncdu liblz4-tool -y
send_enter_if_needed


echo -e "\e[32mSuccessfully Installed - Required Tools\e[0m"

pink_space

# Step 12
echo -e "\e[33mInstalling Go\e[0m"

cd $HOME
sudo wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
tar xvzf go1.22.2.linux-amd64.tar.gz
wait_and_display_message 30 "Installation in Progress..."

# Step 13
echo -e "\e[33mRemoving existing Go installation and installing the new one\e[0m"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz

pink_space

# Create a user directory for the current user
echo -e "\e[33mCreating a user directory for the current user\e[0m"
sudo useradd -d /home/$USER $USER
sudo chown -R $USER:$USER /home/$USER/
echo -e "\e[32mUSER added\e[0m"

pink_space

# Add Go binaries to PATH
echo -e "\e[33mAdding Go Binaries to PATH\e[0m"
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.profile
echo -e "\e[32mGo Binaries added to PATH\e[0m"

pink_space

# Step 7
echo -e "\e[33mCleaning Up Extracted files\e[0m"
rm go1.22.2.linux-amd64.tar.gz
echo -e "\e[32mExtracted Fles Cleaned\e[0m"

pink_space

# Step 14
echo -e "\e[32mSource the profiles to apply changes immediately\e[0m"

pink_space

source ~/.profile
source $HOME/.bashrc


echo -e "\e[32mGo has been installed successfully.\e[0m"

pink_space

# Step 15
check_directory() {
    if [ -d "$1" ]; then
        echo -e "\e[33m$2\e[0m"
    else
        echo -e "\e[31m$3\e[0m"
        exit 1
    fi
}


# Install the binary from source
echo -e "\e[33mInstalling Neutaro binary from source\e[0m"
echo "Please visit https://github.com/Neutaro/Neutaro - To check the latest version"

# A
read -p "Enter the Neutaro version to checkout (e.g., v2.0.0): " version

# B
cd $HOME

# C
git clone https://github.com/Neutaro/Neutaro

# D
cd Neutaro

# E
git checkout "$version"

sleep 10

make build

# F
wait_and_display_message 30 "Installation In Progress"
wait

make install

# G
wait_and_display_message 30 "Download Completed"
wait

pink_space

# Step 16
# Create Neutaro Genesis File
echo -e "\e[33mCreating Neutaro genesis.json File and addrbook.json\e[0m"

# Ask for moniker name
read -p "Enter your moniker name: " moniker_name

# Change directory to the specified location
cd "$HOME/"

# Run the command
Neutaro init "$moniker_name" --chain-id Neutaro-1

Neutaro config chain-id Neutaro-1
Neutaro config keyring-backend os

# Define the genesis.json file paths
CONFIG_DIR="$HOME/.Neutaro/config/"
GENESIS_JSON="$CONFIG_DIR/genesis.json"

# Remove existing JSON file if it exists
if [ -f "$GENESIS_JSON" ]; then
    rm "$GENESIS_JSON"
    echo "Existing genesis.json file removed."
fi

pink_space

source ~/.profile
source $HOME/.bashrc

# Download the new JSON file
#wget -P "$CONFIG_DIR" http://154.26.153.186/genesis.json
curl http://154.26.153.186/genesis.json >$HOME/.Neutaro/config/genesis.json

echo -e "\e[32mNew genesis.json file downloaded\e[0m"

pink_space

#wget -P "$CONFIG_DIR" https://snap1.konsortech.xyz/neutaro/addrbook.json

echo -e "\e[32mNew addrbook.json file downloaded\e[0m"

pink_space

# Step 17

# Snapshot Download
echo -e "\e[33mStarting Snapshot Download\e[0m"
#!/bin/bash

# Move to the home directory
cd $HOME || exit

# Rename the existing directories
mv $HOME/.Neutaro/data $HOME/.Neutaro/data-old
mv $HOME/.Neutaro/wasm $HOME/.Neutaro/wasm-old

# Download the tar.lz4 file
wget https://poker.neutaro.tech/snapshot160724.tar.lz4

# Wait until the file is downloaded
if [ -f snapshot160724.tar.lz4 ]; then
    echo "File downloaded successfully."

    # Decompress the tar.lz4 file
    lz4 -d snapshot160724.tar.lz4

    # Extract the tar file
    tar -xf snapshot160724.tar

    echo "Decompression and extraction completed."
else
    echo "File download failed."
    exit 1
fi

echo -e "\e[32mNew Snapshot Folders unzipped successfully\e[0m"

# Step 20

cd $HOME

cd "$HOME/.Neutaro"

wait_and_display_message 30 "Installation in Progress..."

pink_space

# Step 21
cd $HOME
wait_and_display_message 30 "Creating Neutaro Directory..."

pink_space

# Create systemd file for Neutaro
echo -e "\e[33mCreating systemd daemon for Neutaro\e[0m"


# Define the content for the Neutaro.service file
cat <<EOF | sudo tee /etc/systemd/system/Neutaro.service > /dev/null
[Unit]
Description       = Neutaro Service
Wants             = network-online.target
After             = network-online.target

[Service]
User              = $USER
Type              = simple
ExecStart         = $HOME/go/bin/Neutaro start --home $HOME/.Neutaro
TimeoutStopSec    = 300
LimitNOFILE       = 65535
Restart           = on-failure
RestartSec        = 3
SyslogIdentifier  = Neutaro

[Install]
WantedBy          = multi-user.target
EOF

# Set the permissions for the Neutaro.service file
sudo chmod 644 /etc/systemd/system/Neutaro.service

# Reload systemd to read the new unit file
sudo systemctl daemon-reload

# Enable the Neutaro service to start on boot
sudo systemctl enable Neutaro.service

# Enable the Neutaro service to start on boot
sudo systemctl start Neutaro.service

echo "Neutaro daemon created successfully"

pink_space

wait_and_display_message 30 "Installation in Progress..."

pink_space

# Step 22
check_directory "$HOME/.Neutaro" ".Neutaro directory is created" ".Neutaro directory not found, installation failed"


change_config_values() {
    sed -i 's|seeds = ""|seeds = "0e24a596dc34e7063ec2938baf05d09b374709e6@109.199.106.233:26656,f0184957ed192e1cdbdaaa69126ea85e4f851d28@mainnet-seed.konsortech.xyz:14165"|' "$1/config.toml"
    sed -i 's|pruning = "default"|pruning = "custom"|' "$1/app.toml"
    sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|' "$1/app.toml"
    sed -i 's|pruning-interval = "0"|pruning-interval = "19"|' "$1/app.toml"
    sed -i 's|minimum-gas-prices = "0stake"|minimum-gas-prices = "0uneutaro"|' "$1/app.toml"
    sed -i 's|chain-id = ""|chain-id = "Neutaro-1"|' "$1/client.toml"
}


# Check again $HOME/.Neutaro/config/config.toml and app.toml files
echo "Config and app configuration in progress..."
check_directory "$HOME/.Neutaro/config/" "config.toml file found" "config.toml file not found, configuration failed"
check_directory "$HOME/.Neutaro/config/" "app.toml file found" "app.toml file not found, configuration failed"
check_directory "$HOME/.Neutaro/config/" "client.toml file found" "client.toml file not found, configuration failed"
echo -e "\e[32mConfig and app configuration completed\e[0m"

pink_space

# Step 23
cd $HOME

# Step 6: Change the values in config.toml and app.toml files
change_config_values "$HOME/.Neutaro/config"
echo "Values changed successfully"

echo "Running Neutaro Service"
# Restart the Neutaro service
sudo systemctl restart Neutaro.service


echo -e "\e[32mNeutaro validator Node Setup Completed Successfully\e[0m"

pink_space

# Display the message
echo -e "\e[32m**Neutaro successfully installed in $HOME/.Neutaro**\e[0m"

pink_space

echo -e "\e[5;32mPreparing Services >>>>>>\e[0m"

pink_space

echo "Please run < sudo systemctl status Neutaro > to check the node status"

echo "To start Neutaro = sudo systemctl start Neutaro"
echo "To stop Neutaro = sudo systemctl stop Neutaro"
echo "To restart Neutaro = sudo systemctl restart Neutaro"
echo "To check logs = sudo journalctl --unit=Neutaro --follow"

pink_space

#echo -e "\e[34mHappy Validating\e[0m"
#light_blue_text "**HAPPY VALIDATING!**"

cowsay "Stay positive and HAPPY VALIDATING!"

# Step 24
echo -e "\e[31mInitiating server reboot to apply configuration changes...\e[0m"

pink_space

echo -e "\e[5;32mPreparing for server reboot...\e[0m"

pink_space

echo -e "\e[31m<<< Server is now rebooting >>>\e[0m"

wait_and_display_message 30
sudo reboot
