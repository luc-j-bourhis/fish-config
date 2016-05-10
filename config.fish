# rbenv
if test -d ~/.rbenv
    set -x PATH ~/.rbenv/bin $PATH
    rbenv init - fish | source
end

# plenv
if test -d ~/.plenv
    set -x PATH ~/.plenv/bin $PATH
    plenv init - fish | source
end

# pyenv
if test -d ~/.pyenv
    set -x PATH ~/.pyenv/bin $PATH
    pyenv init - fish | source
    pyenv virtualenv-init - fish | source
end

# git prompt
set __fish_git_prompt_showstashstate     1
set __fish_git_prompt_showupstream       1
set __fish_git_prompt_showdirtystate     1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showupstream       1

set __fish_git_prompt_char_stashstate '◊'
set __fish_git_prompt_char_untrackedfiles '~'

