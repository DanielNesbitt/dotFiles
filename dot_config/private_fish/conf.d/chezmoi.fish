function cza --description "Apply chezmoi changes"
    chezmoi apply $argv
end

function czstat --description "Checks the chezmoi status"
    chezmoi status $argv
end

function czpush --description "Commit and push chezmoi changes"
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "Update chezmoi config"
    end
    set -l src (chezmoi source-path)
    git -C $src add .
    and git -C $src commit -m "$msg"
    and git -C $src push
end

function czpkg --description "Edit chezmoi packages file"
    vim ~/.local/share/chezmoi/.chezmoidata/packages.yaml
end
