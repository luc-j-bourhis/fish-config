# Fish shell completion for the "pod" command of CocoaPods (https://cocoapods.org)

function __
    set cmdline (commandline -opc)
    set cmd_cnt 0
    set cmds
    for opt in $cmdline
        if test (string sub -l 1 $opt) != '-'
            set cmds $cmds $opt
        end
    end
    echo "|$cmds| = |$argv| ??" >> /tmp/comp.log
    if test "$cmds" = "$argv"
        return 0
    end
    return 1
end

complete -c pod -l version -d 'Show the version of the tool'
complete -c pod -l help    -d 'Show help banner of specified command'
complete -c pod -l silent  -d 'Show nothing'
complete -c pod -l verbose -d 'Show more debugging information'
complete -c pod -l no-ansi -d 'Show output without ANSI codes'

complete -c pod -n "__ pod" -a cache            -d 'Manipulate the CocoaPods cache'
complete -c pod -n "__ pod cache" -a clean      -d 'Remove the cache for pods'
complete -c pod -n "__ pod cache clean" -l all  -d 'Remove all the cached pods without asking'

complete -c pod -n "__ pod cache" -a list       -d 'List the paths of pod caches for each known pod'
complete -c pod -n "__ pod cache list" -l short -d 'Only print the path relative to the cache root'

complete -c pod -n "__ pod" -a check            -d 'Displays which Pods would be changed by running `pod install`'

complete -c pod -n "__ pod" -a deintegrate      -d 'Deintegrate CocoaPods from your project'
complete -c pod -n "__ pod deintegrate" -l project-directory -d 'The path to the root of the project directory'
complete -c pod -n "__ pod deintegrate"

complete -c pod -n "__ pod" -a env              -d 'Display pod environment'

complete -c pod -n "__ pod" -a init             -d 'Generate a Podfile for the current directory'
complete -c pod -n "__ pod init"

complete -c pod -n "__ pod" -a install          -d 'Install project dependencies according to versions from a Podfile.lock'
complete -c pod -n "__ pod install" -l repo-update          -d 'Force running `pod repo update` before install'
complete -c pod -n "__ pod install" -l project-directory    -d 'The path to the root of the project directory'


complete -c pod -n "__ pod" -a ipc              -d 'Inter-process communication'
complete -c pod -n "__ pod ipc" -a list         -d 'Lists the specifications known to CocoaPods'
complete -c pod -n "__ pod ipc" -a podfile               -d 'Converts a Podfile to YAML'
complete -c pod -n "__ pod ipc" -a repl                  -d 'The repl listens to commands on standard input'
complete -c pod -n "__ pod ipc" -a spec                  -d 'Converts a podspec to JSON'
complete -c pod -n "__ pod ipc" -a update-search-index   -d 'Updates the search index'


complete -c pod -n "__ pod" -a lib              -d 'Develop pods'
complete -c pod -n "__ pod lib" -a create       -d 'Creates a new Pod'
complete -c pod -n "__ pod lib create" -l template-url -d 'The URL of the git repo containing a compatible template'
complete -c pod -n "__ pod lib" -a lint         -d 'Validates a Pod'
complete -c pod -n "__ pod lib lint" -l quick           -d 'Lint skips checks that would require to download and build the spec'
complete -c pod -n "__ pod lib lint" -l allow-warnings  -d 'Lint validates even if warnings are present'
complete -c pod -n "__ pod lib lint" -l subspec         -d 'Lint validates only the given subspec'
complete -c pod -n "__ pod lib lint" -l no-subspecs     -d 'Lint skips validation of subspecs'
complete -c pod -n "__ pod lib lint" -l no-clean        -d 'Lint leaves the build directory intact for inspection'
complete -c pod -n "__ pod lib lint" -l fail-fast       -d 'Lint stops on the first failing platform or subspec'
complete -c pod -n "__ pod lib lint" -l use-libraries   -d  'Lint uses static libraries to install the spec'
complete -c pod -n "__ pod lib lint" -l sources         -d 'The sources from which to pull dependent pods, comma-delimited.'
complete -c pod -n "__ pod lib lint" -l private         -d 'Lint skips checks that apply only to public specs'
complete -c pod -n "__ pod lib lint" -l swift-version   -d 'The SWIFT_VERSION that should be used to lint the spec'


complete -c pod -n "__ pod" -a list             -d 'List pods'
complete -c pod -n "__ pod list" -l update      -d 'Run `pod repo update` before listing'
complete -c pod -n "__ pod list" -l stats       -d 'Show additional stats (like GitHub watchers and forks)'

complete -c pod -n "__ pod" -a outdated         -d 'Show outdated project dependencies'
complete -c pod -n "__ pod outdated" -l project-directory -d 'The path to the root of the project directory'
complete -c pod -n "__ pod outdated" -l no-repo-update    -d 'Skip running `pod repo update` before install'

complete -c pod -n "__ pod" -a plugins          -d 'Show available CocoaPods plugins'
complete -c pod -n "__ pod plugins" -a create      -d 'Creates a new plugin'
complete -c pod -n "__ pod plugins" -a install     -d 'Install a CocoaPods plugin'
complete -c pod -n "__ pod plugins" -a installed   -d 'List plugins installed on your machine'
complete -c pod -n "__ pod plugins" -a list        -d 'List all known plugins'
complete -c pod -n "__ pod plugins" -a publish     -d 'Request to add the plugin to the official plugins list'
complete -c pod -n "__ pod plugins" -a search      -d 'Search for known plugins'
complete -c pod -n "__ pod plugins search" -l full -d 'Search by name, author, and description'

complete -c pod -n "__ pod" -a repo           -d 'Manage spec-repositories'
complete -c pod -n "__ pod repo" -a add       -d 'Add a spec repo'
complete -c pod -n "__ pod repo add" -l progress   -d 'Show the progress of cloning the spec repository'
complete -c pod -n "__ pod repo" -a lint      -d 'Validates all specs in a repo'
complete -c pod -n "__ pod repo lint" -l only-errors   -d 'Lint presents only the errors'
complete -c pod -n "__ pod repo" -a list      -d 'List repos'
complete -c pod -n "__ pod repo list" -l count-only   -d 'Show the total number of repos'
complete -c pod -n "__ pod repo" -a push      -d 'Push new specifications to a spec-repo'
complete -c pod -n "__ pod repo push" -l allow-warnings         -d 'Allows pushing even if there are warnings'
complete -c pod -n "__ pod repo push" -l use-libraries          -d 'Linter uses static libraries to install the spec'
complete -c pod -n "__ pod repo push" -l sources                -d 'The sources from which to pull dependent pods, comma-delimited.'
complete -c pod -n "__ pod repo push" -l local-only             -d 'Does not perform the step of pushing REPO to its remote'
complete -c pod -n "__ pod repo push" -l no-private             -d 'Lint includes checks that apply only to public repos'
complete -c pod -n "__ pod repo push" -l commit-message         -d 'Add custom commit message or open editor'
complete -c pod -n "__ pod repo push" -l use-json               -d 'Push JSON spec to repo'
complete -c pod -n "__ pod repo push" -l swift-version          -d 'The SWIFT_VERSION that should be used when linting the spec'
complete -c pod -n "__ pod repo" -a remove    -d 'Remove a spec repo'
complete -c pod -n "__ pod repo" -a update    -d 'Update a spec repo'

complete -c pod -n "__ pod" -a search           -d 'Search for pods'
complete -c pod -n "__ pod search" -l regex     -d 'Interpret the `QUERY` as a regular expression'
complete -c pod -n "__ pod search" -l simple    -d 'Search only by name'
complete -c pod -n "__ pod search" -l stats     -d 'Show additional stats (like GitHub watchers and forks)'
complete -c pod -n "__ pod search" -l web       -d 'Searches on cocoapods.org'
complete -c pod -n "__ pod search" -l ios       -d 'Restricts the search to Pods supported on iOS'
complete -c pod -n "__ pod search" -l osx       -d 'Restricts the search to Pods supported on OS X'
complete -c pod -n "__ pod search" -l watchos   -d 'Restricts the search to Pods supported on watchOS'
complete -c pod -n "__ pod search" -l tvos      -d 'Restricts the search to Pods supported on tvOS'
complete -c pod -n "__ pod search" -l no-pager  -d 'Do not pipe search results into a pager'

complete -c pod -n "__ pod" -a setup            -d 'Setup the CocoaPods environment'

complete -c pod -n "__ pod" -a spec             -d 'Manage pod specs'
complete -c pod -n "__ pod spec" -a cat       -d 'Prints a spec file'
complete -c pod -n "__ pod spec cat" -l regex      -d 'Interpret the `QUERY` as a regular expression'
complete -c pod -n "__ pod spec cat" -l show-all   -d 'Pick from all versions of the given podspec'
complete -c pod -n "__ pod spec" -a create    -d 'Create spec file stub.'
complete -c pod -n "__ pod spec" -a edit      -d 'Edit a spec file'
complete -c pod -n "__ pod spec edit" -l regex      -d 'Interpret the `QUERY` as a regular expression'
complete -c pod -n "__ pod spec edit" -l show-all   -d 'Pick from all versions of the given podspec'
complete -c pod -n "__ pod spec" -a lint      -d 'Validates a spec file'
complete -c pod -n "__ pod spect lint" -l quick            -d 'Lint skips checks that would require to download and build the spec'
complete -c pod -n "__ pod spect lint" -l allow-warnings   -d 'Lint validates even if warnings are present'
complete -c pod -n "__ pod spect lint" -l subspec          -d 'Lint validates only the given subspec'
complete -c pod -n "__ pod spect lint" -l no-subspecs      -d 'Lint skips validation of subspecs'
complete -c pod -n "__ pod spect lint" -l no-clean         -d 'Lint leaves the build directory intact for inspection'
complete -c pod -n "__ pod spect lint" -l fail-fast        -d 'Lint stops on the first failing platform or subspec'
complete -c pod -n "__ pod spect lint" -l use-libraries    -d 'Lint uses static libraries to install the spec'
complete -c pod -n "__ pod spect lint" -l sources          -d 'The sources from which to pull dependent pods, comma-delimited'
complete -c pod -n "__ pod spect lint" -l private          -d 'Lint skips checks that apply only to public specs'
complete -c pod -n "__ pod spect lint" -l swift-version    -d 'The SWIFT_VERSION that should be used to lint the spec'
complete -c pod -n "__ pod spec" -a which     -d 'Prints the path of the given spec'
complete -c pod -n "__ pod spec which" -l regex      -d 'Interpret the `QUERY` as a regular expression'
complete -c pod -n "__ pod spec which" -l show-all   -d 'Pick from all versions of the given podspec'

complete -c pod -n "__ pod" -a trunk            -d 'Interact with the CocoaPods API, e.g. publishing new specs'
complete -c pod -n "__ pod trunk" -a add-owner      -d 'Add an owner to a pod'
complete -c pod -n "__ pod trunk" -a delete         -d 'Deletes a version of a pod.'
complete -c pod -n "__ pod trunk" -a deprecate      -d 'Deprecates a pod.'
complete -c pod -n "__ pod trunk" -a info           -d 'Returns information about a Pod.'
complete -c pod -n "__ pod trunk" -a me             -d 'Display information about your sessions'
complete -c pod -n "__ pod trunk me" -a clean-sessions   -d 'Remove sessions'
complete -c pod -n "__ pod trunk me clean-sessions" -l all  -d 'Removes all your sessions, except for the current one'
complete -c pod -n "__ pod trunk" -a push           -d 'Publish a podspec'
complete -c pod -n "__ pod trunk push" -l allow-warnings   -d 'Allows push even if there are lint warnings'
complete -c pod -n "__ pod trunk push" -l use-libraries    -d 'Linter uses static libraries to install the spec'
complete -c pod -n "__ pod trunk push" -l swift-version    -d 'The SWIFT_VERSION that should be used to lint the spec'
complete -c pod -n "__ pod trunk" -a register       -d 'Manage sessions'
complete -c pod -n "__ pod trunk register" -l description -d 'An arbitrary description to easily identify your session later on'
complete -c pod -n "__ pod trunk" -a remove-owner   -d 'Remove an owner from a pod'

complete -c pod -n "__ pod" -a try              -d 'Try a Pod!'
complete -c pod -n "__ pod try" -l podspec_name    -d 'The name of the podspec file within the Git Repository'
complete -c pod -n "__ pod try" -l no-repo-update  -d 'Skip running `pod repo update` before install'

complete -c pod -n "__ pod" -a update           -d 'Update outdated project dependencies and create new Podfile.lock'
complete -c pod -n "__ pod update" -l project-directory -d 'The path to the root of the project directory'
complete -c pod -n "__ pod update" -l no-repo-update    -d 'Skip running `pod repo update` before install'

complete -c pod -f

