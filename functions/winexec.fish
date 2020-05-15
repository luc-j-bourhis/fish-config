function winexec
	set i 1
	for p in $argv[2..-1]
		if string match -r -q '^-' -- $p
			set i (math $i+1)
		else
			break
		end
	end
	set j (math $i+1)
	$argv[1..$i] (winpath $argv[$j..-1])
end
