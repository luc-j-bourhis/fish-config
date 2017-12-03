function prepend_to_fish_user_paths -a path -d 'Prepend first argument to fish_user_paths if not already there'
    contains $path $fish_user_paths; or set -U fish_user_paths $path $fish_user_paths
end
