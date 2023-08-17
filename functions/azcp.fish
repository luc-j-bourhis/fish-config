function azcp -d 'Copy files to and from Azure Storage with scp semantics'
    argparse 'h/help' 'r' -- $argv
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
    azcopy copy $args $argv \
    | stdbuf -o0 tr '\r' '\n' \
    | while read -l li
        if test -z "$log"
            string match -qr '^Log file is located at: (?<log>.*)' "$li"
        else if string match -qr '^(?<progress>\d+\.\d+)\s+%(?<rest>.*)' "$li"
           printf "$progress %% $rest\r"
        end
    end
    if test $pipestatus[1] -ne 0
        echo
        echo "An error occurred: see log file at $log"
        return 1
    end
end

function show_help
    echo 'azcp [-r] SRC DST'
end
