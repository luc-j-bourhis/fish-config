function fish_prompt --description 'Write out the prompt'
	printf '%s%s%s%% ' (set_color --bold normal) (prompt_pwd) (set_color normal)
end
