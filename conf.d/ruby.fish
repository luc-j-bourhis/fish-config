# rbenv
if test -d ~/.rbenv
    fish_add_path -g ~/.rbenv/bin
    rbenv init - | source
end
