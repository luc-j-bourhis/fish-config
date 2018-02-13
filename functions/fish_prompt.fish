function fish_prompt --description 'Write out the prompt'
    if test -n $terminal_is_black
        set_color -o 777
    else
        set_color -o black
    end
    echo -n (prompt_pwd)
    set_color normal
    echo -n '% '
end
