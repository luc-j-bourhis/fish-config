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
    # if the virtualenv plugin for pyenv is not installed,
    # the following will silently fail
    pyenv virtualenv-init - fish | source
end

# ~/bin
if test -d ~/bin
    set -x PATH $PATH ~/bin
end

# Ruby gems installed with --user-install
# We do not try to automatically manage Ruby versions:
# Make sure '*' expands to one and only one version to avoid problems.
# For managing multiple versions, use bundler per project.
if test -d ~/.gem
    set -x PATH ~/.gem/ruby/*/bin $PATH
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
    eval (opam config env)
end

