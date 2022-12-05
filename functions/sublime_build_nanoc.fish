function sublime_build_nanoc -a root filepath -d 'Sublime Text build scheme for nanoc site, which opens the page currently worked on in Safari (MacOS only)'
  pwd
	/usr/local/bin/rbenv exec bundle exec nanoc
    or return $status
  set page (string replace -r '^(.*/)?(test_?)content/' '' $filepath)
  and begin
    set name (basename $page)
    set page (dirname $page)
    if string match -q -r '\.(md|adoc|html)$' $name
      if string match -q -r test_content $filepath
        set page "tests/$page"
      end
      set url "$root/$page"
    else
      set url "$root/"
    end
    set -U last_nanoc_url $url
  end
  echo Opening $last_nanoc_url ...
  if test (osascript \
    -e 'set m to load script file ((path to home folder as text) & "Developer:AppleScript:Open Safari Tab by URL.scpt")' \
    -e "tell m to showTab given someName:\"$last_nanoc_url\"") = false
      open $last_nanoc_url
  end
end
