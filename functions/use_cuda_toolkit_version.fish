function use_cuda_toolkit_version -a wanted_cuda_version
    if ! type -q dpkg
        echo "Unsupported platform"
        return 1
    end
    for li in (dpkg -l 'cuda-toolkit-*')
        if string match -qr '^ii\s+cuda-toolkit-(?<major>\d+)-(?<minor>\d+)' "$li"
            set cuda_versions $cuda_versions $major.$minor
        end
    end
    set cuda_versions (echo $cuda_versions|tr ' ' '\n'|sort|uniq)
    if test -z "$cuda_versions"
        echo "No version of CUDA Toolkit is installed"
        return 1
    end
    if test "$wanted_cuda_version" != none
        if ! contains $wanted_cuda_version $cuda_versions
            echo "Version $wanted_cuda_version of CUDA Toolkit is not installed"
            return 1
        end
    end
    for li in $fish_user_paths
        if ! string match -qr '/usr/local/cuda-\d+\.\d+' $li
            set pruned $pruned $li
        end
    end
    set -g fish_user_paths $pruned
    if test "$wanted_cuda_version" = none
        set -ge LD_LIBRARY_PATH
        set -ge CUDA_TOOLKIT_VERSION
    else
        fish_add_path -g -p /usr/local/cuda-$wanted_cuda_version/bin
        set -gx LD_LIBRARY_PATH /usr/local/cuda-$wanted_cuda_version/lib64
        set -gx CUDA_TOOLKIT_VERSION $wanted_cuda_version
    end
end
