function find_path_upward \
    --description 'Walk directory hierarchy upward to find a file or a directory' \
    -a basename

    # Walk upward
    set -l dir $PWD
    while test $dir != '/'
        set path "$dir/$basename"
        if test -f $path -o -d $path
            echo $path
            return
        end
        set dir (dirname $dir)
    end
    if test -f "/$basename" -o -d "/$basename"
        echo "/$basename"
    else
        echo ''
    end
end
