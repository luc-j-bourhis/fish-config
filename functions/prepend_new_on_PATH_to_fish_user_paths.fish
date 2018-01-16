function prepend_new_on_PATH_to_fish_user_paths \
    -d 'Evaluate the given command and add to fish_user_paths any new path in PATH, keeping the latter pristine'
    set -l OLD_PATH $PATH
    eval $argv
    for p in $PATH
        contains $p $OLD_PATH
        or prepend_to_fish_user_paths $p
    end
    set -g PATH $OLD_PATH
end