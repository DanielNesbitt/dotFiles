# AGENTS.md

Personal chezmoi dotfiles source state, applied to WSL/Arch Linux and macOS.
`CLAUDE.md` in this repo is a symlink to this file.

## Shared config

- `.chezmoidata/packages.yaml` — package lists (`brew`, `pacman`), consumed
  by `run_onchange_macos-install-packages.sh.tmpl` and
  `run_onchange_arch-install-packages.sh.tmpl`. Add a package once here
  rather than editing the install scripts.
- `.chezmoidata/shell-env.yaml` — shared `PATH` entries and env vars,
  rendered by `run_onchange_arch-update-envs.sh.tmpl` into both a fish
  `conf.d` snippet and `~/.config/shell-env.sh`. Despite the "arch" in the
  filename, this script isn't OS-gated — it runs on macOS too.

## .chezmoiignore

Repo-root files that must never be written to `$HOME` (docs, this file,
`CLAUDE.md`) are listed in `.chezmoiignore`. If you add another doc-only
file to the repo root, add it there too and confirm with
`chezmoi apply --dry-run -v` that it doesn't show up as a target write.

## Safety: this repo controls a live machine

`chezmoi apply` writes directly to the invoking user's real `$HOME` and can
run root-privileged install scripts (`sudo pacman -S ...`, Homebrew
installs, `chsh`). Never run `chezmoi apply` speculatively.

- To preview changes, use `chezmoi diff` or `chezmoi apply --dry-run -v`.
- Only run `chezmoi apply` for real when the user asks for it.
