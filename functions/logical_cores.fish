function logical_cores -d "Number of logical cores"
    switch (uname -o)
        case Cygwin
            grep processor /proc/cpuinfo|sort --unique|wc --lines
        case '*'
            echo unknown
    end
end

