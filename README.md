# Virtual Lab Environment — Apple Silicon (M4) Edition
## VMware Fusion + Vagrant | ARM64-Compatible

> **Note:** This is an updated version of the original lab, adapted for Apple Silicon (M1/M2/M3/M4) Macs.
> The original used VirtualBox which does not support ARM. This version uses VMware Fusion with ARM-compatible Bento boxes.

---

## Lab Overview

This Vagrant setup creates two minimal virtual machines for learning and practice:

1. **Debian XFCE** (`debian-gui`) — Debian 12 (Bookworm) with XFCE desktop
   - Box: `bento/debian-12` (ARM64)
   - IP: `192.168.56.10`
   - Memory: 1 GB | CPU: 1 core
   - XFCE desktop environment (lightweight) with LightDM auto-login

2. **Ubuntu CLI** (`ubuntu-cli`) — Ubuntu 22.04 LTS, command-line only
   - Box: `bento/ubuntu-22.04` (ARM64)
   - IP: `192.168.56.11`
   - Memory: 1 GB | CPU: 1 core
   - Headless (no GUI)
   - **2 extra virtual disks (5 GB each)** for storage/partition labs

---

## 💾 Extra Disks — ubuntu-cli

The `ubuntu-cli` VM is provisioned with two additional virtual disks for hands-on storage practice:

| Disk Name          | Size | Purpose                       |
| ------------------ | ---- | ----------------------------- |
| `ubuntu_cli_disk1` | 5 GB | Partition / filesystem labs   |
| `ubuntu_cli_disk2` | 5 GB | LVM / RAID / mount point labs |

Verify disks inside the VM:

```bash
vagrant ssh ubuntu-cli
lsblk
```

---

## System Requirements

- **Mac**: Apple Silicon (M1 / M2 / M3 / M4)
- **RAM**: 4 GB+ available (8 GB recommended)
- **Storage**: 30 GB+ free space
- **macOS**: 12 Monterey or later

---

## Prerequisites Installation

### Step 1: Install VMware Fusion

Download VMware Fusion 13+ (free for personal use):
https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion

Install and open it at least once before continuing.

---

### Step 2: Install Vagrant

```bash
brew install --cask vagrant
```

Or download from: https://developer.hashicorp.com/vagrant/downloads

---

### Step 3: Install Vagrant VMware Utility

Download and install from:
https://developer.hashicorp.com/vagrant/docs/providers/vmware/vagrant-vmware-utility

Then install the Vagrant VMware plugin:

```bash
vagrant plugin install vagrant-vmware-desktop
```

---

### Step 4: Install Git (Optional)

```bash
brew install git
```

---

### Step 5: Verify Installation

```bash
vagrant --version
vagrant plugin list        # should show vagrant-vmware-desktop
```

---

## Usage Instructions

### Initial Setup

```bash
git clone https://github.com/ahmedjorani/Linux-Virtual-Lab-Environment.git
cd Linux-Virtual-Lab-Environment
vagrant up
```

### Start Individual VMs

```bash
vagrant up debian-gui    # Debian XFCE desktop
vagrant up ubuntu-cli    # Ubuntu CLI + extra disks
```

---

## Common Vagrant Commands

```bash
vagrant status           # Show VM states
vagrant ssh debian-gui   # SSH into Debian VM
vagrant ssh ubuntu-cli   # SSH into Ubuntu VM
vagrant suspend          # Save VM state
vagrant resume           # Resume suspended VMs
vagrant halt             # Graceful shutdown
vagrant reload           # Restart + re-apply config
vagrant provision        # Re-run provisioning scripts
vagrant destroy          # Delete VMs (irreversible)
```

---

## Accessing the VMs

### Debian XFCE GUI

- Opens automatically in a VMware Fusion window
- Auto-login as `vagrant` into XFCE desktop
- Credentials: `vagrant` / `vagrant`

### Ubuntu CLI

```bash
vagrant ssh ubuntu-cli

# Or via SSH directly
ssh -i ~/.vagrant.d/insecure_private_keys/vagrant.key.rsa vagrant@192.168.56.11
```

---

## Credentials

| Username  | Password  |
| --------- | --------- |
| `vagrant` | `vagrant` |

Both VMs grant passwordless `sudo` to the `vagrant` user.

---

## Shared Folder

The project directory on your host is synced to `/vagrant` inside both VMs:

```bash
ls /vagrant    # run inside either VM
```

---

## Troubleshooting

### VMware Fusion

- Allow VMware Fusion in **System Settings → Privacy & Security** if blocked on first launch
- Make sure VMware Fusion is fully installed before running `vagrant up`
- If the VM window doesn't open, run `vagrant reload` after `vagrant up`

### Vagrant VMware Plugin

```bash
vagrant plugin install vagrant-vmware-desktop   # install plugin
vagrant plugin update vagrant-vmware-desktop    # update if needed
vagrant plugin list                             # verify installation
```

### General Vagrant

```bash
vagrant box update          # Update boxes to latest version
rm -rf ~/.vagrant.d/boxes/  # Clear cached boxes
vagrant reload              # Reload config changes
vagrant up --debug          # Verbose output for debugging
```

### Extra Disks Not Appearing

- Run `vagrant reload` to re-attach disks after a restart
- Requires Vagrant ≥ 2.2.x with VMware disk support

### Performance

- Increase `vmf.memory` in the Vagrantfile if VMs are slow
- Close unused applications on the host

---

## File Structure

```
Linux-Virtual-Lab-Environment/
├── Vagrantfile       # VM definitions and provisioning (VMware Fusion / ARM)
├── README.md         # This file
├── .gitignore
└── .vagrant/         # Vagrant internal state (do not commit)
```

---

## Customization

Edit `Vagrantfile` to adjust:

- Memory: `vmf.memory = "2048"`
- CPUs: `vmf.cpus = 2`
- Extra disks: add/remove `vm.disk` entries under `ubuntu-cli`

---

## Security Notes

- Default credentials: `vagrant` / `vagrant` — **change before any shared use**
- SSH key automatically copied to `~/.ssh/vagrant.key.rsa` inside each VM
- VMs are isolated in a private network (`192.168.56.0/24`)

---

## ⚠️ DISCLAIMER

**THIS LAB IS FOR EDUCATIONAL AND PRACTICE PURPOSES ONLY**

- Do **not** use in production
- Use at your own risk
- You are responsible for your system and data
- First-time setup will download several GB of box images
- Always backup important data before running `vagrant destroy`
