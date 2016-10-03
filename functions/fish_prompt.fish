function fish_prompt --description 'Write out the prompt'
    set_color -o black
    echo -n (prompt_pwd)
    set_color normal
    echo -n '% '
end
