# rbenv
if test -d ~/.rbenv
    fish_add_path -g ~/.rbenv/bin
    rbenv init - | source
end

# version
function rbvers
    echo (type -q ruby; and ruby -e 'puts RUBY_VERSION'; or echo 'none')
end

