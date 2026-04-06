#!/usr/bin/env bash
# llm.completions.sh — Shell completion for the llm command
#
# Works with both Bash and Zsh.
#
# Bash — add to ~/.bashrc:
#   source /path/to/llm.completions.sh
#
# Zsh — add to ~/.zshrc:
#   source /path/to/llm.completions.sh

_llm_complete() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Walk the command line to find cmd / subcmd / subsubcmd
    # (skip flags so that e.g. "llm -m gpt4 logs list" still works)
    local cmd="" subcmd="" subsubcmd=""
    local i
    for ((i = 1; i < COMP_CWORD; i++)); do
        local w="${COMP_WORDS[i]}"
        [[ "$w" == -* ]] && continue
        if   [[ -z "$cmd"       ]]; then cmd="$w"
        elif [[ -z "$subcmd"    ]]; then subcmd="$w"
        elif [[ -z "$subsubcmd" ]]; then subsubcmd="$w"; break
        fi
    done

    # ── top-level ──────────────────────────────────────────────────────────
    if [[ -z "$cmd" ]]; then
        COMPREPLY=($(compgen -W "
            prompt chat keys logs models templates schemas tools aliases
            fragments plugins install uninstall embed embed-multi
            embed-models similar collections openai
            --version -h --help
        " -- "$cur"))
        return 0
    fi

    case "$cmd" in

        # ── prompt ────────────────────────────────────────────────────────
        prompt)
            case "$prev" in
                -d|--database)       COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                -a|--attachment)     COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                --functions)         COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                -s --system
                -m --model
                -d --database
                -q --query
                -a --attachment
                --at --attachment-type
                -T --tool
                --functions
                --td --tools-debug
                --ta --tools-approve
                --cl --chain-limit
                -o --option
                --schema
                --schema-multi
                -f --fragment
                --sf --system-fragment
                -t --template
                -p --param
                --no-stream
                -n --no-log
                --log
                -c --continue
                --cid --conversation
                --key
                --save
                --async
                -u --usage
                -x --extract
                --xl --extract-last
                -h --help
            " -- "$cur"))
            ;;

        # ── chat ──────────────────────────────────────────────────────────
        chat)
            case "$prev" in
                -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                --functions)   COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                -s --system
                -m --model
                -c --continue
                --cid --conversation
                -f --fragment
                --sf --system-fragment
                -t --template
                -p --param
                -o --option
                -d --database
                --no-stream
                --key
                -T --tool
                --functions
                --td --tools-debug
                --ta --tools-approve
                --cl --chain-limit
                -h --help
            " -- "$cur"))
            ;;

        # ── keys ──────────────────────────────────────────────────────────
        keys)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list get path set -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    set)  COMPREPLY=($(compgen -W "--value -h --help" -- "$cur")) ;;
                    *)    COMPREPLY=($(compgen -W "-h --help" -- "$cur")) ;;
                esac
            fi
            ;;

        # ── logs ──────────────────────────────────────────────────────────
        logs)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list path status backup on off -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        case "$prev" in
                            -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "
                            -n --count
                            -d --database
                            -m --model
                            -q --query
                            -f --fragment
                            -T --tool
                            --tools
                            --schema
                            --schema-multi
                            -l --latest
                            --data
                            --data-array
                            --data-key
                            --data-ids
                            -t --truncate
                            -s --short
                            -u --usage
                            -r --response
                            -x --extract
                            --xl --extract-last
                            -c --current
                            --cid --conversation
                            --id-gt
                            --id-gte
                            --json
                            -e --expand
                            -h --help
                        " -- "$cur"))
                        ;;
                    backup)
                        COMPREPLY=($(compgen -f -- "$cur"))
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── models ────────────────────────────────────────────────────────
        models)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list default options -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        COMPREPLY=($(compgen -W "
                            --options --async --schemas --tools
                            -q --query
                            -m --model
                            -h --help
                        " -- "$cur"))
                        ;;
                    default)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                    options)
                        # models options has its own sub-subcommands
                        if [[ -z "$subsubcmd" ]]; then
                            COMPREPLY=($(compgen -W "list show set clear -h --help" -- "$cur"))
                        else
                            COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        fi
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── templates ─────────────────────────────────────────────────────
        templates)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list show edit path loaders -h --help" -- "$cur"))
            else
                COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
            fi
            ;;

        # ── schemas ───────────────────────────────────────────────────────
        schemas)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list show dsl -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        case "$prev" in
                            -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "
                            -d --database
                            -q --query
                            --full
                            --json
                            --nl
                            -h --help
                        " -- "$cur"))
                        ;;
                    show)
                        case "$prev" in
                            -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "-d --database -h --help" -- "$cur"))
                        ;;
                    dsl)
                        COMPREPLY=($(compgen -W "--multi -h --help" -- "$cur"))
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── tools ─────────────────────────────────────────────────────────
        tools)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        case "$prev" in
                            --functions) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "--json --functions -h --help" -- "$cur"))
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── aliases ───────────────────────────────────────────────────────
        aliases)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list set remove path -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)   COMPREPLY=($(compgen -W "--json -h --help" -- "$cur")) ;;
                    set)    COMPREPLY=($(compgen -W "-q --query -h --help" -- "$cur")) ;;
                    *)      COMPREPLY=($(compgen -W "-h --help" -- "$cur")) ;;
                esac
            fi
            ;;

        # ── fragments ─────────────────────────────────────────────────────
        fragments)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list set show remove loaders -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        COMPREPLY=($(compgen -W "-q --query --aliases --json -h --help" -- "$cur"))
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── plugins ───────────────────────────────────────────────────────
        plugins)
            COMPREPLY=($(compgen -W "--all --hook -h --help" -- "$cur"))
            ;;

        # ── install ───────────────────────────────────────────────────────
        install)
            case "$prev" in
                -e|--editable) COMPREPLY=($(compgen -d -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                -U --upgrade
                -e --editable
                --force-reinstall
                --no-cache-dir
                --pre
                -h --help
            " -- "$cur"))
            ;;

        # ── uninstall ─────────────────────────────────────────────────────
        uninstall)
            COMPREPLY=($(compgen -W "-y --yes -h --help" -- "$cur"))
            ;;

        # ── embed ─────────────────────────────────────────────────────────
        embed)
            case "$prev" in
                -i|--input)    COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                -f|--format)   COMPREPLY=($(compgen -W "json blob base64 hex" -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                -i --input
                -m --model
                --store
                -d --database
                -c --content
                --binary
                --metadata
                -f --format
                -h --help
            " -- "$cur"))
            ;;

        # ── embed-multi ───────────────────────────────────────────────────
        embed-multi)
            case "$prev" in
                -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                --format)      COMPREPLY=($(compgen -W "json csv tsv nl" -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                --format
                --files
                --encoding
                --binary
                --sql
                --attach
                --batch-size
                --prefix
                -m --model
                --prepend
                --store
                -d --database
                -h --help
            " -- "$cur"))
            ;;

        # ── embed-models ──────────────────────────────────────────────────
        embed-models)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list default -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)    COMPREPLY=($(compgen -W "-q --query -h --help" -- "$cur")) ;;
                    default) COMPREPLY=($(compgen -W "--remove-default -h --help" -- "$cur")) ;;
                    *)       COMPREPLY=($(compgen -W "-h --help" -- "$cur")) ;;
                esac
            fi
            ;;

        # ── similar ───────────────────────────────────────────────────────
        similar)
            case "$prev" in
                -i|--input)    COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
            esac
            COMPREPLY=($(compgen -W "
                -i --input
                -c --content
                --binary
                -n --number
                -p --plain
                -d --database
                --prefix
                -h --help
            " -- "$cur"))
            ;;

        # ── collections ───────────────────────────────────────────────────
        collections)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "list delete path -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    list)
                        case "$prev" in
                            -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "-d --database --json -h --help" -- "$cur"))
                        ;;
                    delete)
                        case "$prev" in
                            -d|--database) COMPREPLY=($(compgen -f -- "$cur")); return 0 ;;
                        esac
                        COMPREPLY=($(compgen -W "-d --database -h --help" -- "$cur"))
                        ;;
                    *)
                        COMPREPLY=($(compgen -W "-h --help" -- "$cur"))
                        ;;
                esac
            fi
            ;;

        # ── openai ────────────────────────────────────────────────────────
        openai)
            if [[ -z "$subcmd" ]]; then
                COMPREPLY=($(compgen -W "models -h --help" -- "$cur"))
            else
                case "$subcmd" in
                    models) COMPREPLY=($(compgen -W "--json --key -h --help" -- "$cur")) ;;
                    *)      COMPREPLY=($(compgen -W "-h --help" -- "$cur")) ;;
                esac
            fi
            ;;

    esac

    return 0
}

# Register the completion function for both Bash and Zsh
if [[ -n "${ZSH_VERSION}" ]]; then
    autoload -U +X bashcompinit &>/dev/null && bashcompinit &>/dev/null
fi
complete -F _llm_complete llm
