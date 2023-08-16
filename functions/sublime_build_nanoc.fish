function sublime_build_nanoc -d 'Sublime Text build scheme for nanoc site, which opens the page currently worked on in Safari (MacOS only)'
  # Command-line parsing and validation
  argparse 'host=' 'file=' 'compile-only' -- $argv
  or return 1
  set host $_flag_host
  set filepath $_flag_file

  # Execute
  set nanoc_config (find . -name nanoc.yaml)
  if test -z "$nanoc_config"
    echo 'No Nanoc site could be found'
    return 1
  end
  set nanoc_site (dirname $nanoc_config)
  set name (basename $filepath)
  set page (string replace -r '^.*content' '' (dirname $filepath))
  pushd $nanoc_site
  bundle exec nanoc
  or return $status
  and begin
    if test -n "$_flag_compile_only"
      return 0
    end
    if string match -q -r '\.(md|html)$' $name
      if string match -q -r test_content $filepath
        set page "tests/$page"
      end
      set url "$host/$page"
    else
      set url "$host/"
    end
    set -U last_nanoc_url $url
  end
  echo Opening $last_nanoc_url ...
  if test (osascript \
    -e 'set m to load script file ((path to home folder as text) & "Developer:AppleScript:Open Safari Tab by URL.scpt")' \
    -e "tell m to showTab given someName:\"$last_nanoc_url\"") = false
      open $last_nanoc_url
  end
  popd
end
