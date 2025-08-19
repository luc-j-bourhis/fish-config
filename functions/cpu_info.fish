function cpu_info --no-scope-shadowing -d "Number of available CPUs, cores, or threads"
    argparse -x h,p,l,c -X 0 \
        'h/help' \
        'p/cores' \
        'l/threads' \
        'c/cpus' \
        'all' \
        -- $argv
    or return 1
    if set -q _flag_help
        echo 'Usage: cpu_info [-h | --help] [-p | --cores] [-l | --threads] [-c | --cpus] [--all]'
        echo '       (options are all exclusive)'
        return
    end
    set -l info
    switch (uname)
    case Linux
        for key in 'physical id' 'core id' 'processor'
            set -a info (count (grep $key /proc/cpuinfo | sort --unique))
        end
    case Darwin
        for key in hw.packages machdep.cpu.core_count machdep.cpu.thread_count
            set -a info (sysctl -n $key)
        end
    case '*'
        echo 'Error: unsupported platform'
        return 1
    end
    set cpus $info[1]
    set cores $info[2]
    set threads $info[3]
    if set -q _flag_cores
        echo $cores
    else if set -q _flag_threads
        echo $threads
    else if set -q _flag_cpus
        echo $cpus
    else if set -q _flag_all
        echo "$cpus cpus"
        echo "$cores cores"
        echo "$threads threads"
    end
end

complete -c cpu_info -x -s p -l cores -d 'Number of cores'
complete -c cpu_info -x -s l -l threads -d 'Number of threads'
complete -c cpu_info -x -s c -l cpus -d 'Number of cpus'
complete -c cpu_info -x -s h -l help -d 'Show usage'
complete -c cpu_info -x -l all -d 'Show all informations'
