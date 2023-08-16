function az -d 'Wrapper around azcopy for our Limmat container'
    if not set -q AZURE_HOST
        echo 'Please define environment variable AZURE_HOST'
        return 1
    end
    if not set -q AZURE_SAS
        echo 'Please define environment variable AZURE_SAS: its value is the shared access secret chosen in Azure storage manager'
        return 1
    end
    argparse 'h/help' -- $argv
    if test -n "$_flag_help"
        echo "- az dirs: list the top directories of the container"
        echo "- az CMD args..: pass command and arguments to azcopy"
        echo "In all cases, a prefix 'az:' stands for the Azure storage host"
        return
    end
    for i in (seq (count $argv))
        set a $argv[$i]
        if ! string match -qr '^--' -- $a; and test (string sub -l 3 $a) = 'az:'
            set argv[$i] $AZURE_HOST(string sub -s 4 $a)$AZURE_SAS
        end
    end
    switch $argv[1]
        case dirs
            azcopy list $argv[2..] | perl -pe '$_ = "" if /^$|newer version/; s{^INFO:\s*([^/]+).*$}{$1};' | uniq
        case '*'
            azcopy $argv
    end
end

