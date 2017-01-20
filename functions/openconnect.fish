function openconnect -a subcommand
    set pidfile ~/.cache/openconnect.pid
    ps -a | grep -q openconnect; and set running yes; or set running no
    switch $subcommand
        case status
            if test $running = yes
                echo "openconnect is running"
            else
                echo "openconnect is not running"
            end
        case start
            if test $running = no
                sudo /usr/sbin/openconnect -q --no-cert-check \
                                           -b --pid-file $pidfile \
                                           -u luc.bourhis $OPENCONNECT_URL 
                or echo "openconnect failed to connect to $OPENCONNECT_URL"
            end
        case stop
            if test -f $pidfile
                cat $pidfile | read -l pid
                sudo kill -s SIGINT $pid
                or echo "Failed to stop openconnect process $pid"
                and rm -f $pidfile
            end
        case '*'
            echo "$subcommand is not a subcommand of brukervpn"
    end
end
