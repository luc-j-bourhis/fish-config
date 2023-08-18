function azcp -d 'Copy files to and from Azure Storage with scp semantics'
    argparse 'h/help' 'r' 'v' -- $argv
    if test -n "$_flag_help"
        show_help
        return 0
    end
    if test (count $argv) -ne 2
        show_help
        return 1
    end
    for i in 1 2
        set argv[$i] (string replace -r '^az:(.*)' "$AZURE_HOST"'/$1'"$AZURE_SAS"  "$argv[$i]")
        set on_az[$i] $status
    end
    if test (math bitxor $on_az[1], $on_az[2]) -ne 1
        show_help
        echo 'SRC and DST cannot be both local or both on Azure'
        return 1
    end
    if test -n "$_flag_r"
        set args --recursive=true
    end
    set cmd azcopy copy $args $argv 
    if test -n "$_flag_v"
        echo "Performing `$cmd`"
    end
    $cmd \
    | stdbuf -o0 tr '\r' '\n' \
    | while read -l li
        if test -n "$_flag_v"
            echo $li
        end
        if test -z "$log"
            string match -qr '^Log file is located at: (?<log>.*)' "$li"
        end
        if string match -qr '^(?<progress>\d+\.\d+)\s+%(?<rest>.*)' "$li"
            printf "$progress %% $rest\r"
        else if string match -qr '(F|f)ailed(?!: 0)' "$li"
            echo "E: $li"
        end
        if test -z "$minutes"
            string match -qr 'Elapsed Time \(Minutes\):\s*(?<minutes>.*)' "$li"
        end
        if test -z "$bytes"
            string match -qr 'TotalBytesTransferred:\s*(?<bytes>.*)' "$li"
        end
    end
    if test $pipestatus[1] -ne 0
        if test -n "$log"
            echo
            echo "An error has occured: see log file at $log for more details."
        end
        return 1
    else
        if test -n "$minutes"; and test -n "$bytes"
            set size (numfmt --to=si --suffix=B $bytes)
            set duration (date -u -d@(math "$minutes*60") +%H:%M:%S)
            echo
            echo "$size transferred in $duration"
        end
    end
end

function show_help
    echo 'azcp [-r] SRC DST'
end
