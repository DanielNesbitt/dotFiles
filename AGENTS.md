# AGENTS.md

Personal chezmoi dotfiles source state, applied to WSL/Arch Linux and macOS.
`CLAUDE.md` in this repo is a symlink to this file.

## Shared config

- `.chezmoidata/profiles.yaml` — roles keyed by `.profile`, which is chosen
  once at `chezmoi init` via `.chezmoi.toml.tmpl` and stored in the local
  chezmoi config. Read it with `dig "profile" "" .` (never assume it is set),
  and look up profile data with `dig "profiles" $profile "<key>" <default> .`.
  Several machines can share a profile. Never add hostnames or 1Password
  references to the repo. The prompt text `profile` is part of the interface
  (`chezmoi init --promptChoice profile=<name>`) and must not change.
- `.chezmoidata/packages.yaml` — package lists (`brew`, `pacman`), consumed
  by `run_onchange_macos-install-packages.sh.tmpl` and
  `run_onchange_arch-install-packages.sh.tmpl`. Add a package once here
  rather than editing the install scripts. These are the common lists.
- `.chezmoidata/shell-env.yaml` — shared `PATH` entries and env vars,
  rendered into two places so bash (including agentic tools that spawn one)
  sees the same env as the fish login shell:
  - `dot_config/private_fish/conf.d/chezmoi-env.fish.tmpl` — the fish
    `conf.d` snippet (a managed file).
  - `run_onchange_setup-shell-env.sh.tmpl` — writes `~/.config/shell-env.sh`
    for bash. Runs on every platform, not just Arch.

  Each target has exactly one writer; don't have the script write the fish
  snippet too, or the two will overwrite each other.
- `.chezmoidata/terminal-themes.yaml` — terminal color themes plus the
  active one (`terminal.theme`, overridable per profile via
  `terminal_theme`). Rendered into:
  - `dot_config/ghostty/themes/<Name>.tmpl` — one stub per theme calling
    `.chezmoitemplates/ghostty-theme` (macOS only).
  - `run_onchange_windows-terminal-themes.sh.tmpl` — on WSL, upserts the
    schemes into every Windows Terminal `settings.json` (stable and
    Preview) with `jq` and sets this distro's profile `colorScheme`. WT
    owns the rest of that file, so it is patched, never managed.

  To add a theme, add an entry to the YAML and a matching Ghostty stub.

## .chezmoiignore

Repo-root files that must never be written to `$HOME` (docs, this file,
`CLAUDE.md`) are listed in `.chezmoiignore`. If you add another doc-only
file to the repo root, add it there too and confirm with
`chezmoi apply --dry-run -v` that it doesn't show up as a target write.

## Machine credentials

- `gpg-machine-init` is interactive and creates 1Password items and GPG keys
  on the live machine. Agents must never run it, not even with `--dry-run`,
  because its preflight calls `op`.
- `pinentry-op` reads its 1Password reference from
  `~/.config/pinentry-op/ref`. That file is intentionally unmanaged: never
  add it to the repo or template it.

## Testing chezmoi

- Never run `chezmoi init` without `--config` and `--destination` pointing at
  temp paths. Without them it overwrites the real config.

## Safety: this repo controls a live machine

`chezmoi apply` writes directly to the invoking user's real `$HOME` and can
run root-privileged install scripts (`sudo pacman -S ...`, Homebrew
installs, `chsh`). Never run `chezmoi apply` speculatively.

- To preview changes, use `chezmoi diff` or `chezmoi apply --dry-run -v`.
- Only run `chezmoi apply` for real when the user asks for it.
