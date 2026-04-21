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

## run_once scripts

These scripts run exactly once per machine on `chezmoi apply`. They are all Arch-only and handle setup that cannot be expressed as a managed dotfile.

### `run_once_locales_arch.sh.tmpl`
Uncomments `en_US.UTF-8 UTF-8` in `/etc/locale.gen` and runs `locale-gen` to generate the locale.

### Rootless Podman (WSL)

Three scripts work together to enable rootless Podman in WSL:

1. **`run_once_newuidmap.sh.tmpl`** — Sets `cap_setuid`/`cap_setgid` capabilities on `newuidmap`/`newgidmap` so rootless containers can map user namespaces. Also installs a pacman hook to restore these capabilities after `shadow` package upgrades, which would otherwise strip them.

2. **`run_once_rootfs_shared_mount.sh.tmpl`** — Creates and enables a system-level `rootfs-shared.service` unit that runs `mount --make-rshared /` at boot. WSL mounts the rootfs as private by default, which prevents Podman from creating the bind mounts needed for container overlays.

3. **`run_once_podman_socket.sh.tmpl`** — Enables and starts `podman.socket` at the user level so Docker-compatible tools (e.g. Testcontainers, Docker Compose) can reach Podman via the socket without a running daemon.
