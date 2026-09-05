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

# macOS

- [ ] Install [Homebrew](https://brew.sh):
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- [ ] Install chezmoi:
```sh
brew install chezmoi
```
- [ ] Setup chezmoi. (You may need to generate and add ssh keys.)
```sh
chezmoi init --verbose git@github.com:DanielNesbitt/dotFiles.git
```
- [ ] Apply:
```sh
chezmoi apply
```
This installs the `brew` packages listed in `.chezmoidata/packages.yaml` and switches the login shell to fish — see `run_onchange_macos-install-packages.sh.tmpl` below.

## Shared package/env config

`.chezmoidata/packages.yaml` and `.chezmoidata/shell-env.yaml` are the single source of truth for packages and shell `PATH`/env vars across both platforms. Edit these instead of the install scripts directly.

## run_once scripts

These scripts run exactly once per machine on `chezmoi apply`. They are all Arch-only and handle setup that cannot be expressed as a managed dotfile.

### `run_once_locales_arch.sh.tmpl`
Uncomments `en_US.UTF-8 UTF-8` in `/etc/locale.gen` and runs `locale-gen` to generate the locale.

### Rootless Podman (WSL)

Three scripts work together to enable rootless Podman in WSL:

1. **`run_once_newuidmap.sh.tmpl`** — Sets `cap_setuid`/`cap_setgid` capabilities on `newuidmap`/`newgidmap` so rootless containers can map user namespaces. Also installs a pacman hook to restore these capabilities after `shadow` package upgrades, which would otherwise strip them.

2. **`run_once_rootfs_shared_mount.sh.tmpl`** — Creates and enables a system-level `rootfs-shared.service` unit that runs `mount --make-rshared /` at boot. WSL mounts the rootfs as private by default, which prevents Podman from creating the bind mounts needed for container overlays.

3. **`run_once_podman_socket.sh.tmpl`** — Enables and starts `podman.socket` at the user level so Docker-compatible tools (e.g. Testcontainers, Docker Compose) can reach Podman via the socket without a running daemon.

## run_onchange scripts

These scripts re-run whenever their rendered content changes (e.g. when `.chezmoidata/packages.yaml` gains a package), not just once per machine.

### `run_onchange_macos-install-packages.sh.tmpl`
macOS only. Installs Homebrew if missing, installs the `brew` packages from `packages.yaml`, and switches the login shell to fish if installed.

### `run_onchange_arch-install-packages.sh.tmpl`
Arch only. Installs the `pacman` packages from `packages.yaml` via `sudo pacman -S --needed`, and switches the login shell to fish if installed.

### `run_onchange_setup-shell-env.sh.tmpl`
Platform-independent. Renders `shell-env.yaml`'s `paths` and `envVars` into `~/.config/fish/conf.d/chezmoi-env.fish` and `~/.config/shell-env.sh` (the latter sourced from `~/.bash_profile`), so bash — including agentic tools that spawn a bash shell — sees the same `PATH`/env vars as the fish login shell.
