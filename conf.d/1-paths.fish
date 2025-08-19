# Start clean
set -ge fish_user_paths

# ~/bin
if test -d ~/bin
    fish_add_path -g -a ~/bin
end

# ~/.local/bin
if test -d ~/.local/bin
    fish_add_path -g -a ~/.local/bin
end
