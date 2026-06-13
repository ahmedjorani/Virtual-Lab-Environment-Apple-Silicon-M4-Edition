#!/bin/bash

echo "============================================"
echo "  Virtual Lab Environment — Apple Silicon"
echo "============================================"
echo ""
echo "Which provider do you want to use?"
echo ""
echo "  1) VMware Fusion 13+"
echo "     - Free for personal use"
echo "     - Requires: VMware Fusion + Vagrant VMware Utility + Plugin"
echo ""
echo "  2) VirtualBox 7.2.8 (ARM64)"
echo "     - Free and open source"
echo "     - Requires: VirtualBox 7.2.8 for Apple Silicon"
echo ""
read -p "Enter 1 or 2: " choice

if [ "$choice" = "1" ]; then
  cp _Vagrantfile-VMware Vagrantfile
  echo ""
  echo "✅ Vagrantfile set for VMware Fusion."
  echo ""
  echo "Make sure you have installed:"
  echo "  1. VMware Fusion 13+         → https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion"
  echo "  2. Vagrant VMware Utility    → https://developer.hashicorp.com/vagrant/docs/providers/vmware/vagrant-vmware-utility"
  echo "  3. Vagrant VMware Plugin     → run: vagrant plugin install vagrant-vmware-desktop"
  echo ""
  echo "Then run: vagrant up"

elif [ "$choice" = "2" ]; then
  cp _Vagrantfile-VirtualBox Vagrantfile
  echo ""
  echo "✅ Vagrantfile set for VirtualBox 7.2.8."
  echo ""
  echo "Make sure you have installed:"
  echo "  1. VirtualBox 7.2.8 for Apple Silicon → https://download.virtualbox.org/virtualbox/7.2.8/VirtualBox-7.2.8-173730-macOSArm64.dmg"
  echo ""
  echo "Then run: vagrant up"

else
  echo ""
  echo "❌ Invalid choice. Please run 'bash setup.sh' again and enter 1 or 2."
  exit 1
fi
