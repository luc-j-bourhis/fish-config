function azls -d 'List files on an Azure Storage Server in the manner of ls'
  argparse 'h/help' 'S' 'l' 't' -- $argv
  if test -n "$_flag_help"
    echo "azls [-l] [-S] [-t] AZURE_URL"
    return 0
  end
  set path $argv[1]
  set regex (string join ''\
    '^INFO:\s*'\
    '(?<path>.*?)'\
    ';\s*'\
    'LastModifiedTime:\s*(?<date>\S+) (?<time>\S+)'\
    '.*?;\s*'\
    'Content Length: (?<size>[\d.]+) (?<unit>(K|M|G|T)iB)')
  for li in (azcopy list --properties LastModifiedTime (az $path))
    string match -qr "$regex" "$li"
    set len (string length $path)
    if not set -q maxlen; or test $len -gt $maxlen
      set maxlen $len
    end
    set listed "$path" 
    if test -n "$_flag_l"
      set -a listed $date $time $size $unit
    end
    if test -n "$_flag_S"
      set -a listing $size$unit $listed
    else if test -n "$_flag_t"
      set -a listing $date$time $listed
    else
      set -a listing $listed
    end
  end
  set pathfmt "%-$maxlen""s"  
  if test -n "$_flag_l"
      set format "$pathfmt %s %s %7.2f %s\n"
  else
      set format "$pathfmt\n"
  end
  if test -n "$_flag_S"
    printf "%s\t$format" $listing | sort -rh | cut -f2-
  else if test -n "$_flag_t"
    printf "%s\t$format" $listing | sort -r | cut -f2-
  else
    printf $format $listing | sort
  end
end

