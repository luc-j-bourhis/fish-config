function cpu_info --no-scope-shadowing
    argparse -n cpu_info -x p,l -X 0 'p/physical' 'l/logical' -- $argv
    or return
    set -l key
    switch (uname)
    case Linux 'CYGWIN*'
        if set -q _flag_p
            set key 'core id'
        else if set -q _flag_l
            set key processor
        end
        count (grep $key /proc/cpuinfo|sort --unique)
    case Darwin
        if set -q _flag_p
            set key machdep.cpu.core_count
        else if set -q _flag_l
            set key machdep.cpu.thread_count
        end
        sysctl -n $key
    case '*'
        echo 'Unknown'
    end
end

complete -c cpu_info -s p -l physical -d 'Number of physical cores'
complete -c cpu_info -s l -l logical -d 'Number of logical cores'
