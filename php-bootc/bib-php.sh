[customizations.installer.kickstart]
contents = """
lang en_US.UTF-8
keyboard us
timezone Etc/UTC --utc
text

zerombr
clearpart --all --initlabel
reqpart --add-boot
part / --grow --fstype xfs

rootpw --lock
reboot

network --bootproto=dhcp

%post --log=/var/log/anaconda/post-install.log --erroronfail

# local user for console login and SSH
useradd -g wheel core
echo "core:redhat123" | chpasswd
mkdir /home/core/.ssh
cat > /home/core/.ssh/authorized_keys << EOFSSH
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICG7J8XuYk2jhZLvd33VTRQO6YZlCfPMBVB7rF8lf+SK initial key for edge devices
EOFSSH

echo "bootc-fpm" > /etc/hostname
chmod 644 /etc/hostname
%end
"""
