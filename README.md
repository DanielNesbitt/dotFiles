# WSL

- [ ] Install wsl as an administrator `wsl --install`.
- [ ] Install a [NerdFont](https://www.nerdfonts.com/font-downloads).
- [ ] Install Arch Linux in WSL.
```
wsl --install archlinux
```
- [ ] Setup the system in the initial console.
```sh
# 1. Set root password
passwd

# 2. Create user
useradd -m -G wheel -s /bin/bash USERNAME

# 3. Set user password
passwd USERNAME

# 4. Configure sudo
mkdir -p /etc/sudoers.d
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

# Update pacman
pacman -Syu
exit
```
- [ ] Set the default user.
```
wsl --manage archlinux --set-default-user username
```
- [ ] Setup chezmoi.
```sh
sudo pacman -S chezmoi
```
