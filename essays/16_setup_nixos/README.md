# Setup NixOS

## Steps

Created a live CD for NixOS with an easy ´dd´ command
<https://nixos.org/manual/nixos/stable/#sec-booting-from-usb>

Booted from the live CD USB Stick and installed NixOS through UI. Erased whole disk and enabled encryption, swap with hypernation.
On the first try i had an error. So I needed add nix-channel --add, and nix-channel --update

Activated Token2 for LUKS: <https://www.token2.com/site/page/unlock-linux-luks-encrypted-drives-with-token2-fido2-security-keys>
The part with crypttab needs to be done different, see the next link
Actibated Token2 for NixOS: <https://nixos.org/manual/nixos/stable/#sec-luks-file-systems-fido2-systemd>
Dont forget to remove your initial password for all partitions, i use a second fido2 as backup. ´sudo cryptsetup luksRemoveKey /dev/sdX´ and enter your passphrase to remove.

Authentication: <https://www.token2.com/site/page/using-token2-fido2-security-keys-for-linux-local-authentication>
i used the passwordless version. make sure you map both keys (including backup key)
the structure of the u2f_mappings ´<username>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>:...´
See the details for nixos here: <https://nixos.wiki/wiki/Yubikey>
Check also the testing part <https://nixos.wiki/wiki/Yubikey#Test_PAM_configuration>
After this i also enabled pin
´´´ bash
security.pam.services = {
login = {
u2fAuth = true;
rules.auth.u2f.args = lib.mkAfter [
"pinverification=0"
"userverification=1"
];
};
sudo = {
u2fAuth = true;
rules.auth.u2f.args = lib.mkAfter [
"pinverification=0"
"userverification=1"
];
};
};
´´´

And now remove the default login for the user
´´´ bash
security.pam.services = {
login = {
unixAuth = false;
u2fAuth = true;
rules.auth.u2f.args = lib.mkAfter [
"pinverification=0"
"userverification=1"
];
};
sudo = {
unixAuth = false;
u2fAuth = true;
rules.auth.u2f.args = lib.mkAfter [
"pinverification=0"
"userverification=1"
];
};
};
´´´

Creating SSH Keys with resident option ´-O resident´ <https://www.token2.com/site/page/using-token2-fido2-security-keys-for-openssh>
´ssh-keygen -t ed25519-sk -O resident -C "Main"´
´ssh-keygen -t ed25519-sk -O resident -C "Backup"´

- add yubikey to config and make it more generic for other hosts: <https://joinemm.dev/blog/yubikey-nixos-guide>
- change to Home Manager <https://nixos.wiki/wiki/Home_Manager>
- change structure to <http://gitlab.com/thomas-zahner/Nix>
  remove git /etc/nixos but instead use a folder in ~ with the style of thomas and rebuild with ´nixos-rebuild switch --flake '.#laptop'
- install wayland

## Steps

- Installed Ubuntu on a second stick (hier live cd von nixos <https://nixos.org/download/#nixos-iso>)
- Starte Ubuntu
- Create LUKS encrypted partition
  lsblk
  sudo parted /dev/sdX -- mklabel gpt
  sudo parted /dev/sdX -- mkpart ESP fat32 8192s 512MiB
  sudo parted /dev/sdX -- set 1 esp on
  sudo parted /dev/sdX -- mkpart primary 1048576s 100%
  verify alignment: sudo parted /dev/sdX align-check optimal 1
  sudo parted /dev/sdX align-check optimal 2
  cryptsetup luksFormat --type luks2 /dev/sdX2
  123456

//not done on nixos
sudo apt install systemd-cryptenroll
Check for Token2 systemd-cryptenroll --fido2-device=list
For all tokens: sudo systemd-cryptenroll /dev/sdX2 --fido2-device=auto --fido2-with-client-pin=yes

Test:
lsblk
sudo cryptsetup close cryptroot
sudo cryptsetup open --token-only /dev/sdX2 cryptoroot
lsblk

//went here
no btrfs cause just an overhead for nixos. ext4 is fine
sudo mkfs.ext4 /dev/mapper/nixos_usb
mkfs.vfat -n EFI /dev/sdX1
sudo mount /dev/mapper/nixos_usb /mnt
sudo mkdir -p /mnt/boot
sudo mount -o umask=077 /dev/sdX1 /mnt/boot

sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile

sudo install curl
sh <(curl -L <https://nixos.org/nix/install>) --no-daemon
nix-shell -p nixos-install-tools

<https://wiki.nixos.org/wiki/Creating_a_NixOS_live_CD>
until you get the iso
ls result/iso

sudo nixos-generate-config --root /mnt
sudo vi /mnt/etc/nixos/configuration.nix

```

```

sudo nix-channel --update

sudo nixos-install

- <https://www.token2.swiss/site/page/unlock-linux-luks-encrypted-drives-with-token2-fido2-security-keys>
