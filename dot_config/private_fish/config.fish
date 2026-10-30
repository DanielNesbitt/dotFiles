if status is-interactive
    # Commands to run in interactive sessions can go here

    set -g fish_greeting

    # Atuin initialization
    if command -v atuin >/dev/null
        atuin init fish --disable-up-arrow | source
    end

    # Starship initialization
    if command -v starship >/dev/null
        starship init fish | source
    end

    # Zoxide initialization
    if command -v zoxide >/dev/null
        zoxide init fish | source
    end

    # Direnv initialization
    if command -v direnv >/dev/null
        direnv hook fish | source
    end

    # Mise initialization
    #if command -v mise > /dev/null
    #    mise activate fish | source
    #end
end
