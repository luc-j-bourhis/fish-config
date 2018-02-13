function physical_processors -d "Number of physical processors"
    switch (uname -o)
        case Cygwin    
            grep 'physical id' /proc/cpuinfo|sort --unique|wc --lines
        case '*'
            echo unknown
    end
end

