# Start clean
set -Ue fish_user_paths

# rbenv
if type -q rbenv
    rbenv init - | source
end

# plenv
if type -q plenv
    plenv init - | source
end

# pyenv
if type -q pyenv
    pyenv init - fish | source
end

# ~/bin
if test -d ~/bin
    append_to_fish_user_paths ~/bin
end

# git-subrepo
if test -d ~/Developer/git-subrepo
    append_to_fish_user_paths ~/Developer/git-subrepo/lib
end

# Settings for interactive sessions only
status --is-interactive; and test -f ~/.config-interactive.fish; and source ~/.config-interactive.fish

# Miniconda
if test -d ~/opt/miniconda3
    eval ~/opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    # Disable official conda prompt as it has an uwanted space in it
    # The sourcing we have just done has saved fish_right_prompt
    # on entry to __fish_right_prompt_orig
    functions -e fish_right_prompt
    functions -q __fish_right_prompt_orig; and begin
        functions -c __fish_right_prompt_orig fish_right_prompt
    end
end

# git prompt
set __fish_git_prompt_showstashstate     1
set __fish_git_prompt_showupstream       1
set __fish_git_prompt_showdirtystate     1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showupstream       1

set __fish_git_prompt_char_stashstate '◊'
set __fish_git_prompt_char_untrackedfiles '~'

# OPAM configuration
if type -q opam
    prepend_new_on_PATH_to_fish_user_paths (opam config env)
end

# Kernel name
set -q kernel_name; or set -U kernel_name (uname -s)
if string match -q 'CYGWIN*' $kernel_name
    set -U kernel_name Cygwin
end

