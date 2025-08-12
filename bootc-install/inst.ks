%pre --erroronfail
mkdir -p /mnt/host-var-srv
mount -t virtiofs -o ro host-var-srv /mnt/host-var-srv
%end

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

ostreecontainer --transport oci --url /mnt/host-var-srv/oci:httpd-bootc

%post --log=/var/log/anaconda/post-install.log --erroronfail

# local user for console login and SSH
useradd -g wheel core
echo "core:redhat123" | chpasswd
mkdir /home/core/.ssh
cat > /home/core/.ssh/authorized_keys << EOFSSH
REPLACE_WTH_SSH_PUB_KEY
EOFSSH

echo "bootc-test" > /etc/hostname
chmod 644 /etc/hostname
%end
