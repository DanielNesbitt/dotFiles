function cza --description "Apply chezmoi changes"
    chezmoi apply $argv
end

function czpush --description "Commit and push chezmoi changes"
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "Update chezmoi config"
    end
    chezmoi git add -A
    and chezmoi git commit -- -m "$msg"
    and chezmoi git push
end

function czpkg --description "Edit chezmoi packages file"
    vim ~/.local/share/chezmoi/.chezmoidata/packages.yaml
end
