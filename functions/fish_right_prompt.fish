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

    # Do we have a Python virtual environment?
    if test -n $PYENV_VIRTUALENV_INIT
        set py_venv (pyenv virtualenvs | \
                     perl -ne 'm{^\*\s*(\S+)} and print $1 or print ""')
        if test -n "$py_venv"
            set vers[1] "$py_venv"
        end
    end

    set fvers (echo $vers|perl -pe 's{\.\d+(?=\s)}{}g; s{\s+}{\n}g')

    printf "%s[%s]%s[%s]%s[%s]%s"   \
        (set_color yellow) $fvers[1] \
        (set_color red)    $fvers[2] \
        (set_color blue)   $fvers[3] \
        (set_color normal)
end
