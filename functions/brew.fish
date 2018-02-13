function brew -d 'Wrapper around Homebrew to avoid pollution of PATH'
    set -l old_fish_user_paths $fish_user_paths
    set -e fish_user_paths
    command brew $argv
    set -U fish_user_paths $old_fish_user_paths
end
