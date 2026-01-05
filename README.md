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

# Install bootstrap dependencies
pacman -S chezmoi git openssh
exit
```
- [ ] Set the default user.
```
wsl --manage archlinux --set-default-user username
```
- [ ] Setup chezmoi. (You may need to generate and add ssh keys.)
```sh
chezmoi init --verbose git@github.com:DanielNesbitt/dotFiles.git
```
- [ ] Restart the session to change into the new shell
