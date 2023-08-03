function myip -d 'Local IP address'
    switch $kernel_name
        case Darwin
            ifconfig -l | xargs -n1 ipconfig getifaddr
        case Linux
            echo (hostname -I | string split ' ')[1]
        case *
            echo 'Not implemented on this OS'
            return -1
    end
end
