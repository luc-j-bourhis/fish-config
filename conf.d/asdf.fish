if type -q asdf
    fish_add_path ~/.asdf/shims
    asdf completion fish | source
end
