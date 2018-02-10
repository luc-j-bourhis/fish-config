# rbenv
if test -d ~/.rbenv
    status --is-interactive; and source (rbenv init -|psub)
end

# plenv
if test -d ~/.plenv
    prepend_to_fish_user_paths ~/.plenv/bin
    plenv init - fish | source
end

# local::lib
if test -d ~/.perl5
    prepend_new_on_PATH_to_fish_user_paths (perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)
end

# pyenv
if test -d ~/.pyenv
    prepend_to_fish_user_paths ~/.pyenv/bin $PATH
    pyenv init - fish | source
    # if the virtualenv plugin for pyenv is not installed,
    # the following will silently fail
    pyenv virtualenv-init - fish | source
end

# ~/bin
if test -d ~/bin
    append_to_fish_user_paths ~/bin
end

# Miniconda
if test -d ~/miniconda3
    prepend_to_fish_user_paths ~/miniconda3/bin
    source ~/miniconda3/etc/fish/conf.d/conda.fish
    # Remove "official" conda completions if requested
    if set -q my_fish_disable_official_conda_completions
        complete -c conda -e
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
