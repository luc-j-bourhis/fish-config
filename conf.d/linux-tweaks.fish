if test $kernel_name != Linux
	return
end

# Disable single-quotes around path with spaces in the output of command ls
# A really stupid change introduced in coreutils in recent years
set -x QUOTING_STYLE literal
