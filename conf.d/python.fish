# pyenv
if test -d ~/.pyenv
    fish_add_path -g ~/.pyenv/bin
    pyenv init - fish | source
end

# Poetry
if test -f ~/.local/bin/poetry
    fish_add_path -g ~/.local/bin
end

# Version
function pyvers
    set -l pycmd 'import platform; print(platform.python_version())'
    if type -q python3
        echo (python3 -c $pycmd)
    else if type -q python
        echo (python -c $pycmd)
    else
        echo none
    end
end
