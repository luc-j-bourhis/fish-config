function winpath
	for p in $argv
		set p (realpath -s $p)
		set p (string replace -r '^/cygdrive/([a-z])' '$1:' $p)
		or set p c:/cygwin64$p
		echo $p
	end
end
