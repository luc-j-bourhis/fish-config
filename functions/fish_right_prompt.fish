function rbvers
    echo (type ruby > /dev/null ^&1; and ruby -e 'puts RUBY_VERSION'; or echo 'none')
end

function pyvers
    echo (python -c 'import platform; print(platform.python_version())')
end

function plvers
    perl -e '$_=$^V; s/^v//; print'
end

function fish_right_prompt
    # conda
    if set -q CONDA_DEFAULT_ENV
        echo -n "($CONDA_DEFAULT_ENV)"
    end

    # git (the prompt has a hardwired leading space we need to remove)
    string trim (__fish_git_prompt)

    # versions of Python, Ruby and Perl
    set -l vers
    for lang in py rb pl
        set -l cmd {$lang}env
        if type -q $cmd
            set ver (eval $cmd version-name)
        else
            set ver (eval {$lang}vers)
        end
        set vers $vers $ver
    end

    # Do we have a Python virtual environment?
    if test -n "$PYENV_VIRTUALENV_INIT"
        set py_venv (pyenv virtualenvs | \
                     perl -ne 'm{^\*\s*(\S+)} and print $1 or print ""')
        if test -n "$py_venv"
            set vers[1] "$py_venv"
        end
    end

    set_color yellow
    printf "[%s]" $vers[1]
    set_color red
    printf "[%s]" $vers[2]
    set_color blue
    printf "[%s]" $vers[3]
    set_color normal
end
