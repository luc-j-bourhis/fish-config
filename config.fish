# Start clean
set -ge fish_user_paths

# rbenv
if test -d ~/.rbenv
    fish_add_path -g ~/.rbenv/bin
    rbenv init - | source
end

# plenv
if test -d ~/.plenv
    fish_add_path -g ~/.plenv/bin
    plenv init - | source
end

# pyenv
if test -d ~/.pyenv
    fish_add_path -g ~/.pyenv/bin
    pyenv init - fish | source
end

# Poetry
if test -f ~/.local/bin/poetry
    fish_add_path -g ~/.local/bin
end

# ~/bin
if test -d ~/bin
    fish_add_path -g -a ~/bin
end

# ~/.local/bin
if test -d ~/.local/bin
    fish_add_path -g -a ~/.local/bin
end

# Settings for interactive sessions only
status --is-interactive; and test -f ~/.config-interactive.fish; and source ~/.config-interactive.fish

# Conda right prompt color
set MY_CONDA_PROMPT_COLOUR 009193 # Apple Teal

# Miniconda
if test -d ~/opt/miniconda3
    ~/opt/miniconda3/bin/conda "shell.fish" "hook" \
    | perl -pe "s/set_color -o green/set_color $MY_CONDA_PROMPT_COLOUR/" \
    | source
end

# Micromamba
# Beware not to have both Miniconda (above) and Micromamba active at the same time!
# Move one or the other relevant directory out of the way
if type -q micromamba
    set -gx MAMBA_EXE (type -p micromamba)
    if test -z "$MAMBA_ROOT_PREFIX"
        if test -d ~/micromamba
            set -gx MAMBA_ROOT_PREFIX ~/micromamba
        end
    end
    if test -n "$MAMBA_ROOT_PREFIX"
        micromamba shell hook --shell fish \
        | perl -pe "s/set_color -o green/set_color $MY_CONDA_PROMPT_COLOUR/" \
        | source
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

# Disable single-quotes around path with spaces in the output of command ls
# A really stupid change introduced in coreutils in recent years
set -x QUOTING_STYLE literal

# git subrepo
if test -d ~/Developer/git-subrepo
    source ~/Developer/git-subrepo/.fish.rc
end
