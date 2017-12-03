function sublime_build_nanoc --a filepath -d 'Sublime Text build scheme for nanoc site, which opens the page currently worked on in Safari (MacOS only)'
	bundle exec nanoc
    or exit $status
    if string match -q '*.md' $filepath
        set -U last_nanoc_url (string replace -r '^.*/content/' 'http://192.168.1.200:4000/' (dirname $filepath))
    end
    echo Opening $last_nanoc_url ...
    if test (osascript \
      -e 'set m to load script file ((path to home folder as text) & "Developer:AppleScript:Open Safari Tab by URL.scpt")' \
      -e "tell m to showTab given someName:\"$last_nanoc_url\"") = false
        open $last_nanoc_url
    end
end
