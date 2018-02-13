function physical_cores -d "Number of physical cores"
    switch (uname -o)
        case Cygwin
            grep 'core id' /proc/cpuinfo|sort --unique|wc --lines
        case '*'
            echo unknown
    end
end

