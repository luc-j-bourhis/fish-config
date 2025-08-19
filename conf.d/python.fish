# pyenv
if test -d ~/.pyenv
    fish_add_path -g ~/.pyenv/bin
    pyenv init - fish | source
end

# Poetry
if test -f ~/.local/bin/poetry
    fish_add_path -g ~/.local/bin
end
