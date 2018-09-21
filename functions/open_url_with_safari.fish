function open_url -a loc -d 'Open the given location in the default browser'
    # If `fish_help_browser` is set to this function, then `help` will call
    # `open_url --version` because `open_url` is not listed as a graphical browser
    # and fish then tests whether the browser is Lynx. Hence this hack: we ignore
    # that option, making sure fish will conclude we are not Lynx!
    if test $loc = --version
        return
    end
    osascript -e "tell (load script \"$my_applescript_folder/Open Location.scpt\") to openLocation(\"$loc\")"
end
