# Google Cloud Debian VM Setup with XRDP, GNOME, and Visual Studio Code

This project consists of two files: 
1. `debian-remote-desktop-on-gcp.sh`: A shell script to create a Google Cloud VM instance with Debian 12.
2. `debian-remote-desktop-on-gcp_script.sh`: A startup script that installs GNOME, XRDP, configures root access, and installs Visual Studio Code on the VM.

## Overview

This repository contains the necessary scripts to automate the setup of a **Debian 12** virtual machine on **Google Cloud** using **gcloud CLI**. The VM will have **GNOME** as the desktop environment, **XRDP** for remote access, and **Visual Studio Code** pre-installed.

### Files:
- **emptydebian_v1.sh**: A script to create a Google Cloud VM with the required specifications.
- **emptydebian_v1_script.sh**: A startup script to be executed on the VM to set up GNOME, XRDP, and Visual Studio Code.

### Features:
- Provisions a **Debian 12** virtual machine using **Google Cloud**.
- Installs **GNOME** desktop environment.
- Configures **XRDP** for remote desktop access via RDP.
- Sets up **root login** with password authentication over XRDP.
- Installs **Visual Studio Code**.
- Customizes GNOME settings (background color, window button layout).

## Prerequisites

### Software Requirements:
1. **Google Cloud SDK (gcloud)**: Ensure the gcloud CLI is installed and configured.
   - [Google Cloud SDK Installation Guide](https://cloud.google.com/sdk/docs/install)
   
2. **Google Cloud Project**: You must have a valid Google Cloud project with **billing enabled**.

### Permissions:
- You must have permissions to create instances and manage resources in your Google Cloud project.

## Usage

### Step 1: Clone the Repository
Clone the repository to your local machine:

git clone https://github.com/ccaiccie/debian-remote-desktop-on-gcp.git
cd debian-remote-desktop-on-gcp

### Step 2: Run the VM Creation Script
Before you run the script, make sure you have authenticated with Google Cloud using the gcloud CLI:

gcloud auth login
gcloud config set project <your-project-id>

Run the script `emptydebian_v1.sh` to create the VM:

bash emptydebian_v1.sh

This will:
- Create a **Debian 12** VM in **Google Cloud** using the latest Debian 12 image.
- Set up XRDP and GNOME for remote desktop access.
- Install **Visual Studio Code** and configure the environment.

### Step 3: Access the VM via XRDP
Once the VM is created and the startup script has finished running:
1. Use an **RDP client** (e.g., **Remote Desktop Connection** on Windows or **Remmina** on Linux) to connect to your VM.
2. Use your VM's **public IP address** and **port 3389** for XRDP.
3. Log in with the **root user** and the password specified in the script (`your_new_password`).

### Step 4: Customizing the Script
You can modify the `emptydebian_v1_script.sh` file to:
- Set a different root password by editing the line:

echo "rdpuser:your_new_password" | sudo chpasswd

- Customize the GNOME environment, XRDP settings, or install additional software by updating the startup script as needed.

## Contents of the Project

### `debian-remote-desktop-on-gcp.sh`
This script provisions a Debian 12 VM on Google Cloud. The VM is created with the following specifications:
- **Machine Type**: `n2-standard-4`
- **20 GB Balanced Persistent Disk**
- **Spot Instance** (to save costs)
- **Remote Desktop Access**: Enabled via XRDP (Port 3389)
- **Startup Script**: Includes the necessary setup for GNOME, XRDP, and Visual Studio Code.

### `debian-remote-desktop-on-gcp_script.sh`
This script is passed to the VM as a **startup script**. It performs the following tasks:
- Installs **GNOME** and **XRDP**.
- Configures **root login** with password authentication for XRDP.
- Installs **Visual Studio Code**.
- Configures GNOME to set the background and window button layout (minimize, maximize, close).

### Step 5: Cleanup
To avoid unnecessary costs, remember to delete the VM when you're done using it:

gcloud compute instances delete debianvmdesktop --zone=<your-zone>

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
