# plenv
if test -d ~/.plenv
    fish_add_path -g ~/.plenv/bin
    plenv init - | source
end
