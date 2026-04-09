# bash completion for btrfs-file-history

_btrfs_file_history() {
    local cur prev words cword
    _init_completion || return

    if [[ $cword -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "tree history diff -h --help -V --version" -- "$cur") )
        return
    fi

    case "${words[1]}" in
        tree)
            COMPREPLY=( $(compgen -W "--format --no-color" -- "$cur") )
            ;;
        history)
            COMPREPLY=( $(compgen -W "--checksum --extents --du --no-tree --format --filter --no-color" -- "$cur") )
            ;;
        diff)
            ;;
    esac
}

complete -F _btrfs_file_history btrfs-file-history
