function meld
	switch $kernel_name
	    case 'Cygwin'
			winexec '/cygdrive/c/Program Files (x86)/Meld/Meld.exe' $argv 2> /dev/null
		case *
			command meld $argv
	end
end
