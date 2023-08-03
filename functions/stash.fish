function stash -d "Copy a file xxx to xxx-stash and vice versa (poor man git stash)"
    switch $argv[1]
        case pop
            for f in $argv[2..-1]
                echo "Popping stash of $f"
                mv $f-head $f
            end
        case apply
            for f in $argv[2..-1]
                echo "Applying stash of $f"
                cp $f-head $f
            end        
        case drop
            for f in $argv[2..-1]
                echo "Dropping stash of $f"
                rm $f-head
            end
        case show
            find . -name '*-head' -printf '%Tc %p\n' 2> /dev/null | string replace -r -- '-head$' ''
        case diff
            for f in $argv[2..-1]
                echo "Diffing stash of $f"
                diff -Naur $f $f-head
            end        
        case push '*'
             for f in $argv
                if ! test -f $f
                    echo "No such file: $f. Skipping..."
                    continue
                end
                if test -f "$f-head"
                    read -P "There is stash of file $f: overwrite [y/any key]" -n 1 -l ans
                    if test $ans != "y"
                        echo "Skipping..."
                        continue
                    end
                end
                echo "Stashing $f"
                cp $f $f-head
            end

    end
end
