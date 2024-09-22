# Google Cloud Debian VM Setup with XRDP, GNOME, and Visual Studio Code

This project consists of two files: 
1. `emptydebian_v1.sh`: A shell script to create a Google Cloud VM instance with Debian 12.
2. `emptydebian_v1_script.sh`: A startup script that installs GNOME, XRDP, configures root access, and installs Visual Studio Code on the VM.

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
```bash
git clone https://github.com/yourusername/repository-name.git
cd repository-name
