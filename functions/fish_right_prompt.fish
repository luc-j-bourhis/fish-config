function fish_right_prompt
    # git (the default format has a leading space I don't want)
    set_color normal
    __fish_git_prompt "(%s)"

    # versions of various interpreters and compilers
    set -l vers
    set -l languages_short py rb pl ml
    set -l languages_long python ruby perl ocaml
    # Colours picked on official web sites
    set -l languages_colour '#FFDA4C' '#CD342D' '#004E74' '#F18803'
    set languages_count (count $languages_short)
    for i in (seq $languages_count)
        set -l lang $languages_short[$i]
        if not set -q my_fish_shows_{$languages_long[$i]}_prompt
            set vers $vers n/a
            continue
        end
        set -l cmd {$lang}env
        if type -q $cmd
            set ver (eval $cmd version-name|string replace system sys)
        else
            set ver (eval {$lang}vers)
        end
        set vers $vers $ver
    end

    # Do we have a Python virtual environment?
    if test -n "$PYENV_VIRTUALENV_INIT"
        set py_venv (pyenv virtualenvs | \
                     perl -ne 'm{^\*\s*(\S+)} and print $1 or print ""')
        if test -n "$py_venv"
            set vers[1] "$py_venv"
        end
    else
        set vers[1] (eval pyvers)
    end

    for i in (seq $languages_count)
        if set -q my_fish_shows_{$languages_long[$i]}_prompt
            set_color $languages_colour[$i]
            printf "[%s]" (string replace -r "\.\d+\z" "" $vers[$i])
        end
    end
    set_color normal
end
