# plenv
if test -d ~/.plenv
    fish_add_path -g ~/.plenv/bin
    plenv init - | source
end

# Version
function plvers
    perl -e '$_=$^V; s/^v//; print'
end
