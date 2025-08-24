# Configure
opam config env | source

# Version
function mlvers
	set switch_name (opam switch show)
	if test "$switch_name" = "$PWD"
		set switch_name "."
	end
	echo $switch_name
end
