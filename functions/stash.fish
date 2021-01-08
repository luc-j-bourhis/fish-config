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
            find . -name '*-head' 2> /dev/null | string replace -r -- '-head$' ''
        case push '*'
            for f in $argv
                echo "Stashing $f"
                cp $f $f-head
            end
    end
end
