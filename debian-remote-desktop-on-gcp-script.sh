#!/bin/bash

# Define a file that marks the installation as complete
MARKER_FILE="/opt/xrdp_installed"

# Check if the marker file exists
exec > /var/log/startup-script.log 2>&1
if [ ! -f "$MARKER_FILE" ]; then
    export DEBIAN_FRONTEND="noninteractive"
    echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections
    echo "APT::Get::Assume-Yes \"true\";" > /tmp/_tmp_apt.conf
    export APT_CONFIG=/tmp/_tmp_apt.conf
    sudo apt-get update -y

    echo "XRDP and GNOME installation starting..."

    # Install GNOME and XRDP
    sudo apt-get install -y gnome-core gnome-terminal xrdp

    # Enable the XRDP service to start on boot
    sudo systemctl enable xrdp
    sudo systemctl start xrdp

    # Allow XRDP to use the default GNOME session
    echo "gnome-session" > ~/.xsession

    # Allow root login via XRDP by changing the password
    echo "root:your_new_password" | sudo chpasswd

    # Enable root login with a password by updating the SSH config
    sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

    # Restart SSH service to apply changes
    sudo systemctl restart sshd

    # Allow port 3389 for XRDP in the firewall (if UFW is installed)
    if command -v ufw >/dev/null 2>&1; then
        sudo ufw allow 3389/tcp
        sudo ufw reload
    fi

    # Add xrdp user to ssl-cert group to prevent certificate issues
    sudo adduser xrdp ssl-cert

    # Create a marker file to indicate that the installation is complete
    sudo touch "$MARKER_FILE"
    echo "XRDP and GNOME installation completed."
        # Set GNOME desktop background to black and set window button layout min, max, close
    echo -e "#!/bin/bash\n\n# Set the GNOME desktop background for the current user\ngsettings set org.gnome.desktop.background picture-uri \"\"\ngsettings set org.gnome.desktop.background primary-color \"#000000\"\ngsettings set org.gnome.desktop.background secondary-color \"#000000\"\ngsettings set org.gnome.desktop.background color-shading-type \"solid\"\n\n# Set the GNOME window button layout (minimize, maximize, close)\ngsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'\n" | sudo tee /etc/profile.d/set-background-and-buttons.sh
    sudo chmod +x /etc/profile.d/set-background.sh
    # Update the dconf database to apply settings
    sudo dconf update
    # Install Visual Studio Code
    wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
    sudo dpkg -i vscode.deb

else
    echo "XRDP and GNOME already installed, skipping setup."
fi
