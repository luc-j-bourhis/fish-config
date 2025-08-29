# **** This is run after anything in conf.d ****

# Settings for interactive sessions only
status --is-interactive; and test -f ~/.config-interactive.fish; and source ~/.config-interactive.fish

# Per machine customisation
test -f ./this_machine.fish; and source ./this_machine.fish

# Run `manpath` as late as possible because it uses PATH
set MANPATH $MANPATH (manpath)
