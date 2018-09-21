function open_url_with_safari -a loc -d 'Open the given location in Safari browser'
    if test $kernel_name != Darwin
        echo (status function) is only available on MacOS
        return
    end
    # If `fish_help_browser` is set to this function, then `help` will call
    # `open_url --version` because `open_url` is not listed as a graphical browser
    # and fish then tests whether the browser is Lynx. Hence this hack: we ignore
    # that option, making sure fish will conclude we are not Lynx!
    if test $loc = --version
        return
    end
    set applescript "Open Location.scpt"
    set applescript_path (dirname (status current-filename))/$applescript
    if test ! -f $applescript_path
        echo (status function) cannot work without the Applescript \"$applescript\"
        echo Available from my Applescript github repo
        return 1
    end
    osascript -e "tell (load script \"$applescript_path\") to openLocation(\"$loc\")"
end
