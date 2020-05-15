function subl
	switch $kernel_name
	    case 'Cygwin'
			winexec '/cygdrive/c/Program Files/Sublime Text 3/subl.exe' $argv
		case *
			command subl $argv
	end
end
