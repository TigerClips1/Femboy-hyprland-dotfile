# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_ppm_global_optspecs
    string join \n market-url= plugins-dir= h/help V/version
end

function __fish_ppm_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_ppm_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_ppm_using_subcommand
    set -l cmd (__fish_ppm_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c ppm -n "__fish_ppm_needs_command" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_needs_command" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c ppm -n "__fish_ppm_needs_command" -s V -l version -d 'Print version'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "search" -d 'Search plugins on the Pumpkin Marketplace'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "find" -d 'Search plugins on the Pumpkin Marketplace'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "info" -d 'View detailed information about a plugin'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "show" -d 'View detailed information about a plugin'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "install" -d 'Download and install a plugin (.wasm) into the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "add" -d 'Download and install a plugin (.wasm) into the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "get" -d 'Download and install a plugin (.wasm) into the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "uninstall" -d 'Remove an installed plugin from the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "remove" -d 'Remove an installed plugin from the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "rm" -d 'Remove an installed plugin from the plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "installed" -d 'List plugins currently installed in the local plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "list-installed" -d 'List plugins currently installed in the local plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "ls" -d 'List plugins currently installed in the local plugins directory'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "update" -d 'Update installed plugin(s) to the latest version from the marketplace'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "upgrade" -d 'Update installed plugin(s) to the latest version from the marketplace'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "new" -d 'Scaffold a new plugin project template (interactive TUI or flag-driven)'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "init" -d 'Scaffold a new plugin project template (interactive TUI or flag-driven)'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "create" -d 'Scaffold a new plugin project template (interactive TUI or flag-driven)'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "self-install" -d 'Install ppm into your user/system PATH (~/.local/bin)'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "setup" -d 'Install ppm into your user/system PATH (~/.local/bin)'
complete -c ppm -n "__fish_ppm_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ppm -n "__fish_ppm_using_subcommand search" -s c -l category -d 'Filter by category (e.g., Utilities, Fun, Admin Tools, Economy)' -r
complete -c ppm -n "__fish_ppm_using_subcommand search" -s t -l type -d 'Filter by plugin type (free, paid, adwall)' -r
complete -c ppm -n "__fish_ppm_using_subcommand search" -s l -l limit -d 'Maximum number of plugins to return' -r
complete -c ppm -n "__fish_ppm_using_subcommand search" -s p -l page -d 'Page number (starting at 1)' -r
complete -c ppm -n "__fish_ppm_using_subcommand search" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand search" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand search" -l json -d 'Output results in JSON format'
complete -c ppm -n "__fish_ppm_using_subcommand search" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand find" -s c -l category -d 'Filter by category (e.g., Utilities, Fun, Admin Tools, Economy)' -r
complete -c ppm -n "__fish_ppm_using_subcommand find" -s t -l type -d 'Filter by plugin type (free, paid, adwall)' -r
complete -c ppm -n "__fish_ppm_using_subcommand find" -s l -l limit -d 'Maximum number of plugins to return' -r
complete -c ppm -n "__fish_ppm_using_subcommand find" -s p -l page -d 'Page number (starting at 1)' -r
complete -c ppm -n "__fish_ppm_using_subcommand find" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand find" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand find" -l json -d 'Output results in JSON format'
complete -c ppm -n "__fish_ppm_using_subcommand find" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand info" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand info" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand info" -l json -d 'Output plugin details as JSON'
complete -c ppm -n "__fish_ppm_using_subcommand info" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand show" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand show" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand show" -l json -d 'Output plugin details as JSON'
complete -c ppm -n "__fish_ppm_using_subcommand show" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand install" -s o -l output -d 'Custom output file name or path (only valid when installing a single plugin)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand install" -l token -d 'Account access token for paid or private marketplace plugins' -r
complete -c ppm -n "__fish_ppm_using_subcommand install" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand install" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand install" -s f -l force -d 'Overwrite existing plugin file if already present'
complete -c ppm -n "__fish_ppm_using_subcommand install" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand add" -s o -l output -d 'Custom output file name or path (only valid when installing a single plugin)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand add" -l token -d 'Account access token for paid or private marketplace plugins' -r
complete -c ppm -n "__fish_ppm_using_subcommand add" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand add" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand add" -s f -l force -d 'Overwrite existing plugin file if already present'
complete -c ppm -n "__fish_ppm_using_subcommand add" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand get" -s o -l output -d 'Custom output file name or path (only valid when installing a single plugin)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand get" -l token -d 'Account access token for paid or private marketplace plugins' -r
complete -c ppm -n "__fish_ppm_using_subcommand get" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand get" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand get" -s f -l force -d 'Overwrite existing plugin file if already present'
complete -c ppm -n "__fish_ppm_using_subcommand get" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand uninstall" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand uninstall" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand uninstall" -s y -l yes -d 'Skip confirmation prompt'
complete -c ppm -n "__fish_ppm_using_subcommand uninstall" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand remove" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand remove" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand remove" -s y -l yes -d 'Skip confirmation prompt'
complete -c ppm -n "__fish_ppm_using_subcommand remove" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand rm" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand rm" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand rm" -s y -l yes -d 'Skip confirmation prompt'
complete -c ppm -n "__fish_ppm_using_subcommand rm" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand installed" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand installed" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand installed" -l json -d 'Output installed plugins as JSON'
complete -c ppm -n "__fish_ppm_using_subcommand installed" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand list-installed" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand list-installed" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand list-installed" -l json -d 'Output installed plugins as JSON'
complete -c ppm -n "__fish_ppm_using_subcommand list-installed" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand ls" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand ls" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand ls" -l json -d 'Output installed plugins as JSON'
complete -c ppm -n "__fish_ppm_using_subcommand ls" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand update" -l token -d 'Account access token for paid plugins' -r
complete -c ppm -n "__fish_ppm_using_subcommand update" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand update" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand update" -s c -l check -d 'Only check for updates without downloading'
complete -c ppm -n "__fish_ppm_using_subcommand update" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand upgrade" -l token -d 'Account access token for paid plugins' -r
complete -c ppm -n "__fish_ppm_using_subcommand upgrade" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand upgrade" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand upgrade" -s c -l check -d 'Only check for updates without downloading'
complete -c ppm -n "__fish_ppm_using_subcommand upgrade" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand new" -s l -l lang -d 'Programming language: rust, python (py), csharp (cs), c, go, kotlin (kt), d, zig, typescript (ts)' -r
complete -c ppm -n "__fish_ppm_using_subcommand new" -s a -l author -d 'Author name' -r
complete -c ppm -n "__fish_ppm_using_subcommand new" -l description -d 'Description of the plugin' -r
complete -c ppm -n "__fish_ppm_using_subcommand new" -s d -l dir -d 'Target directory to generate the project in' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand new" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand new" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand new" -s y -l non-interactive -d 'Do not prompt interactively; use defaults for unspecified options'
complete -c ppm -n "__fish_ppm_using_subcommand new" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand init" -s l -l lang -d 'Programming language: rust, python (py), csharp (cs), c, go, kotlin (kt), d, zig, typescript (ts)' -r
complete -c ppm -n "__fish_ppm_using_subcommand init" -s a -l author -d 'Author name' -r
complete -c ppm -n "__fish_ppm_using_subcommand init" -l description -d 'Description of the plugin' -r
complete -c ppm -n "__fish_ppm_using_subcommand init" -s d -l dir -d 'Target directory to generate the project in' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand init" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand init" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand init" -s y -l non-interactive -d 'Do not prompt interactively; use defaults for unspecified options'
complete -c ppm -n "__fish_ppm_using_subcommand init" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand create" -s l -l lang -d 'Programming language: rust, python (py), csharp (cs), c, go, kotlin (kt), d, zig, typescript (ts)' -r
complete -c ppm -n "__fish_ppm_using_subcommand create" -s a -l author -d 'Author name' -r
complete -c ppm -n "__fish_ppm_using_subcommand create" -l description -d 'Description of the plugin' -r
complete -c ppm -n "__fish_ppm_using_subcommand create" -s d -l dir -d 'Target directory to generate the project in' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand create" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand create" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand create" -s y -l non-interactive -d 'Do not prompt interactively; use defaults for unspecified options'
complete -c ppm -n "__fish_ppm_using_subcommand create" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand self-install" -s d -l dir -d 'Custom target directory (defaults to ~/.local/bin)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand self-install" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand self-install" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand self-install" -s f -l force -d 'Force overwrite existing binary if already present'
complete -c ppm -n "__fish_ppm_using_subcommand self-install" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand setup" -s d -l dir -d 'Custom target directory (defaults to ~/.local/bin)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand setup" -l market-url -d 'Pumpkin Marketplace API base URL' -r
complete -c ppm -n "__fish_ppm_using_subcommand setup" -l plugins-dir -d 'Directory where plugins are installed (auto-detected if inside server root or plugins folder)' -r -F
complete -c ppm -n "__fish_ppm_using_subcommand setup" -s f -l force -d 'Force overwrite existing binary if already present'
complete -c ppm -n "__fish_ppm_using_subcommand setup" -s h -l help -d 'Print help'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "search" -d 'Search plugins on the Pumpkin Marketplace'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "info" -d 'View detailed information about a plugin'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "install" -d 'Download and install a plugin (.wasm) into the plugins directory'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "uninstall" -d 'Remove an installed plugin from the plugins directory'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "installed" -d 'List plugins currently installed in the local plugins directory'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "update" -d 'Update installed plugin(s) to the latest version from the marketplace'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "new" -d 'Scaffold a new plugin project template (interactive TUI or flag-driven)'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "self-install" -d 'Install ppm into your user/system PATH (~/.local/bin)'
complete -c ppm -n "__fish_ppm_using_subcommand help; and not __fish_seen_subcommand_from search info install uninstall installed update new self-install help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
