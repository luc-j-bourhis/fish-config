function fish_right_prompt
    # git
    __fish_git_prompt

    # versions of Python, Ruby and Perl
    set -l vers
    for cmd in pyenv rbenv plenv
        if type -q $cmd
            set ver (eval $cmd version-name)
        else
            set ver sys
        end
        set vers $vers $ver
    end

    set fvers (echo $vers|perl -pe 's{\.\d+(?=\s)}{}g; s{\s+}{\n}g')

    printf "%s[%s]%s[%s]%s[%s]%s"   \
        (set_color yellow) $fvers[1] \
        (set_color red)    $fvers[2] \
        (set_color blue)   $fvers[3] \
        (set_color normal)
end
