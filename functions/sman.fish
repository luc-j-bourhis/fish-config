function sman --description 'Display a nicely formatted manpage for the given command' \
              --wraps man
    switch $kernel_name
        case Darwin
	       open -a Bwana man:$argv[1]
        case Linux
            yelp man:$argv[1] ^/dev/null >/dev/null &
        case '*'
            echo $kernel_name: unsupported platform
            return 1
    end
end
