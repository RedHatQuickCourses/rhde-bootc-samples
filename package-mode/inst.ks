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

url --url=http://content.example.com/rhel10.0/x86_64/dvd/

%packages
@core
@base
%end

%post --log=/var/log/anaconda/post-install.log --erroronfail

# local user for console login and SSH
useradd -g wheel core
echo "core:redhat123" | chpasswd
mkdir /home/core/.ssh
cat > /home/core/.ssh/authorized_keys << EOFSSH
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9Pcobrw2K22DdXjauEkgJqwNvDDU4v+stiArvdsUF5 initial key for edge devices
EOFSSH

echo "rpm-test" > /etc/hostname
chmod 644 /etc/hostname
%end
