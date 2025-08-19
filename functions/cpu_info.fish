function cpu_info --no-scope-shadowing \
    -d "The computer has one or more CPU's, each with one or more cores, each running one or more thread"
    argparse -n cpu_info -x p,l,c -X 0 \
        'p-cores' \
        'l-threads' \
        'c-cpus' \
        -- $argv
    or return
    set -l key
    switch (uname)
    case Linux
        if set -q _flag_cores
            set key 'core id'
        else if set -q _flag_threads
            set key processor
        else if set -q _flag_cpus
            set key 'physical id'
        end
        count (grep $key /proc/cpuinfo|sort --unique)
    case Darwin
        if set -q _flag_cores
            set key machdep.cpu.core_count
        else if set -q _flag_threads
            set key machdep.cpu.thread_count
        else if set -q _flag_cpus
            set key hw.packages
        end
        sysctl -n $key
    case '*'
        echo 'Unknown'
    end
end

complete -c cpu_info -l cores -d 'Number of cores'
complete -c cpu_info -l threads -d 'Number of threads'
complete -c cpu_info -l cpus -d 'Number of cpus'
