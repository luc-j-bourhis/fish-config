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
