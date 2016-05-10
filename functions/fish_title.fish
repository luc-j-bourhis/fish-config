function fish_title --description 'Set window title'
	if test $_ != "fish"
        echo "$_ – "
    end
	echo (prompt_pwd)
end
