# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "debian-gui" do |debian_gui|
    debian_gui.vm.box = "bento/debian-12"
    debian_gui.vm.hostname = "debian-gui"
    debian_gui.vm.network "private_network", ip: "192.168.56.10"

    debian_gui.vm.provider "vmware_fusion" do |vmf|
      vmf.name = "Debian-gui"
      vmf.memory = "1024"
      vmf.cpus = 1
      vmf.gui = true
    end

    debian_gui.vm.provision "file",
      source: "~/.vagrant.d/insecure_private_keys/vagrant.key.rsa",
      destination: "~/.ssh/vagrant.key.rsa"

    debian_gui.vm.provision "shell", name: "setup", inline: <<-SHELL
      set -e
      apt-get update
      apt-get upgrade -y

      id -u vagrant &>/dev/null || useradd -m -s /bin/bash vagrant
      echo 'vagrant:vagrant' | chpasswd
      usermod -aG sudo vagrant
      echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant
      chmod 440 /etc/sudoers.d/vagrant

      DEBIAN_FRONTEND=noninteractive apt-get install -y \
        task-xfce-desktop \
        lightdm \
        lightdm-gtk-greeter \
        spice-vdagent

      mkdir -p /etc/lightdm/lightdm.conf.d/
      cat > /etc/lightdm/lightdm.conf.d/50-vagrant-autologin.conf << 'EOF2'
[Seat:*]
autologin-user=vagrant
autologin-user-timeout=0
user-session=xfce
EOF2

      systemctl enable lightdm
      systemctl set-default graphical.target

      chmod 600 /home/vagrant/.ssh/vagrant.key.rsa
      chown vagrant:vagrant /home/vagrant/.ssh/vagrant.key.rsa

      nohup bash -c "sleep 5 && reboot" &>/dev/null &
    SHELL
  end

  config.vm.define "ubuntu-cli" do |ubuntu_cli|
    ubuntu_cli.vm.box = "bento/ubuntu-22.04"
    ubuntu_cli.vm.hostname = "ubuntu-cli"
    ubuntu_cli.vm.network "private_network", ip: "192.168.56.11"

    ubuntu_cli.vm.provider "vmware_fusion" do |vmf|
      vmf.name = "Ubuntu-cli"
      vmf.memory = "1024"
      vmf.cpus = 1
      vmf.gui = false
    end

    ubuntu_cli.vm.disk :disk, size: "5GB", name: "ubuntu_cli_disk1"
    ubuntu_cli.vm.disk :disk, size: "5GB", name: "ubuntu_cli_disk2"

    ubuntu_cli.vm.provision "file",
      source: "~/.vagrant.d/insecure_private_keys/vagrant.key.rsa",
      destination: "~/.ssh/vagrant.key.rsa"

    ubuntu_cli.vm.provision "shell", inline: <<-SHELL
      chmod 600 /home/vagrant/.ssh/vagrant.key.rsa
      chown vagrant:vagrant /home/vagrant/.ssh/vagrant.key.rsa
    SHELL
  end

  config.vm.box_check_update = false
  config.ssh.insert_key = false
  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant", disabled: false

end
