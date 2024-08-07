function fish_prompt --description 'Write out the prompt'
    if test -n $terminal_is_black
        set_color -o 777
    else
        set_color -o black
    end
    if test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
        set h (hostname)
        if test $h != $MY_LOCAL_HOSTNAME
            echo -n (hostname):
        end
    end
    echo -n (prompt_pwd)
    set_color normal
    echo -n '% '
end
