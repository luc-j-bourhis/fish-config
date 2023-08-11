function checkports -d 'checkports IP port [port] [port] ...: run nmap on each port and print a clean report'
    for p in $argv[2..]
        nmap $argv[1] -Pn -p $p
    end \
    | perl -lne '/^PORT/ and do {print unless  $header++}; m{^\d+/} and print'
end
