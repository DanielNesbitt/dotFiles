function czpush --description "Commit and push chezmoi changes"
    set -l msg $argv[1]
    
    if test -z "$msg"
        set msg "Update chezmoi config"
    end
    
    chezmoi git add .
    and chezmoi git commit -- -m "$msg"
    and chezmoi git push
end
