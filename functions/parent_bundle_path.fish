function parent_bundle_path \
    --description "The path of the MacOS bundle containing a file" \
    --argument filepath
	set p (realpath $filepath)
    set p (dirname $p)
    while test $p != '/'
        if test -f $p/Info.plist -a -d $p/Resources
            echo (dirname $p)
            return
        end
        set p (realpath $p/..)
    end
end
