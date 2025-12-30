if status is-interactive
# Commands to run in interactive sessions can go here

    set -g fish_greeting

	# Atuin initialization
    if command -v atuin > /dev/null
        atuin init fish --disable-up-arrow | source
	end

    # Starship initialization
    if command -v starship > /dev/null
        starship init fish | source
    end

    if test -d $HOME/.cargo/bin
        set -gx PATH $HOME/.cargo/bin $PATH
    end

    if test -d $HOME/.local/bin
        set -gx PATH $HOME/.local/bin $PATH
    end
end
