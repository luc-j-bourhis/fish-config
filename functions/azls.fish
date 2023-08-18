function azls -d 'List files on an Azure Storage Server in the manner of ls'
        argparse 'h/help' 'S' 'l' 't' -- $argv
        if test -n "$_flag_help"
                echo "azls [-l] [-S] [-t] PATH"
                echo "The PATH is either relative to the root of \$AZURE_HOST"
                echo "or / refers to the root of \$AZURE_HOST"
                return 0
        end
        set path $argv[1]
        set regex (string join ''\
                '^INFO:\s*'\
                '(?<path>.*?)'\
                ';\s*'\
                'LastModifiedTime:\s*(?<date>\S+) (?<time>\S+)'\
                '.*?;\s*'\
                'Content Length: (?<size>[\d.]+) (?<unit>B|(K|M|G|T)iB)')
        for li in (azcopy list --properties LastModifiedTime (az $path))
                string match -qr "$regex" "$li"
                or continue
                set len (string length $path)
                if not set -q maxlen; or test $len -gt $maxlen
                        set maxlen $len
                end
                set listed "$path" 
                if test -n "$_flag_l"
                        set -a listed $date $time $size $unit
                end
                if test -n "$_flag_S"
                        set -a listing $size$unit $listed
                else if test -n "$_flag_t"
                        set -a listing $date$time $listed
                else
                        set -a listing $listed
                end
        end
        set pathfmt "%-$maxlen""s"  
        if test -n "$_flag_l"
                        set format "$pathfmt %s %s %7.2f %s\n"
        else
                        set format "$pathfmt\n"
        end
        if test -n "$_flag_S"
                set sortargs "-rh"
        else if test -n "$_flag_t"
                set sortargs "-r"
        end
        if set -q sortargs
                printf "%s\t$format" $listing | sort $sortargs | cut -f2-
        else
                printf $format $listing | sort
        end
end

