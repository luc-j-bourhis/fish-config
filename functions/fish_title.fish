function fish_title --description 'Set window title'
    if set -q MY_HOSTNAME_ALIAS
        set t $MY_HOSTNAME_ALIAS
    else
        set t (hostname)
    end
    if test $_ != "fish"
        set t1 "$_ – "
    else
        set t1 (prompt_pwd)
    end
    echo "$t - $t1"
end
