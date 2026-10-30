# AGENTS.md

Personal chezmoi dotfiles source state, applied to WSL/Arch Linux and macOS.
`CLAUDE.md` in this repo is a symlink to this file.

## Shared config

- `.chezmoidata/packages.yaml` — package lists (`brew`, `pacman`), consumed
  by `run_onchange_macos-install-packages.sh.tmpl` and
  `run_onchange_arch-install-packages.sh.tmpl`. Add a package once here
  rather than editing the install scripts. These are the common lists.
- `.chezmoidata/machines.yaml` — per-machine extras keyed by
  `.chezmoi.hostname`, installed on top of the common lists. Hosts without
  an entry get only the common packages.
- `.chezmoidata/shell-env.yaml` — shared `PATH` entries and env vars,
  rendered into two places so bash (including agentic tools that spawn one)
  sees the same env as the fish login shell:
  - `dot_config/private_fish/conf.d/chezmoi-env.fish.tmpl` — the fish
    `conf.d` snippet (a managed file).
  - `run_onchange_setup-shell-env.sh.tmpl` — writes `~/.config/shell-env.sh`
    for bash. Runs on every platform, not just Arch.

  Each target has exactly one writer; don't have the script write the fish
  snippet too, or the two will overwrite each other.

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
