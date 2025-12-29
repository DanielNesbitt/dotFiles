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

    alias pkgedit='vim ~/.local/share/chezmoi/.chezmoidata/packages.yaml'
end
