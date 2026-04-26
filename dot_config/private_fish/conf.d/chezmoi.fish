function cza --description "Apply chezmoi changes"
    chezmoi apply $argv
end

function czstat --description "Checks the chezmoi status"
    chezmoi status $argv
end

function czpush --description "Commit and push chezmoi changes"
    set -l msg "$argv"

    if test -z "$msg"
        set msg "Update chezmoi config"
    end

    chezmoi git add .
    and chezmoi git commit -- -m "$msg"
    and chezmoi git push
end

function czup --description "Pull and apply chezmoi updates"
    chezmoi update
end

function czpkg --description "Edit chezmoi packages file"
    vim ~/.local/share/chezmoi/.chezmoidata/packages.yaml
end

function czcd --description "Change to the chezmoi directory"
    chezmoi cd
end
