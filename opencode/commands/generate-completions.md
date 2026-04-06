---
description: Generate bash/zsh tab-completion for any CLI command
---

Generate a shell completion script for the command invoked as: `$ARGUMENTS`

## Output file

- Derive the command name from the `Usage:` line of the help output (typically the last word of `$ARGUMENTS`).
- Write the file to the current directory as `<name>.completions.sh`.

## Requirements for the generated file

- Works in both Bash and Zsh from a single file.
- Bash: register with `complete -F _<name>_complete <name>`.
- Zsh: call `autoload -U +X bashcompinit && bashcompinit` then the same `complete`.
- Flags that take a file or directory path must trigger file/directory completion.
- Flags with a fixed set of valid values must complete only those values.
- Every subcommand, sub-subcommand, and their flags must be covered.

## Discovery process — follow these steps exactly

1. **Top-level help** is already included below. Read it and extract:
   - All top-level flags.
   - Every listed subcommand name.

2. **For each subcommand** found, run `$ARGUMENTS <subcommand> --help 2>&1 || $ARGUMENTS <subcommand> -h 2>&1` using your bash tool.
   - Extract its flags.
   - Note any further sub-subcommands listed under "Commands:".

3. **Recurse** into every sub-subcommand the same way, until no new "Commands:" sections appear.

4. **Only after** the full tree is explored, write the completed `<name>.completions.sh` file.

## Top-level help

!`$ARGUMENTS --help 2>&1 || $ARGUMENTS -h 2>&1`
