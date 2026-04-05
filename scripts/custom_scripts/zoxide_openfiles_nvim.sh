#!/bin/bash

# Find files and open in nvim using fzf + zoxide
# alias: nzo

search_with_zoxide() {
    if [ -z "$1" ]; then
        # No arg: search files in current dir
        file="$(fd --type f -I -H -E .git -E .git-crypt -E .cache -E .backup | fzf --height=70% --preview='bat -n --color=always --line-range :500 {}')"
        if [ -n "$file" ]; then
            dir="$(dirname "$file")"
            file_name="$(basename "$file")"
            cd "$dir" || { echo "Failed to cd to $dir" >&2; exit 1; }
            nvim "$file_name"
        fi
    else
        # With arg: search current dir (shallow) -> current dir (deep) -> zoxide dirs
        lines=$(fd --type f --max-depth 1 -I -H -E .git -E .git-crypt -E .cache -E .backup -E .vscode "$1" . 2>/dev/null)

        if [ -z "$lines" ]; then
            lines=$(fd --type f -I -H -E .git -E .git-crypt -E .cache -E .backup -E .vscode "$1" . 2>/dev/null)
        fi

        if [ -z "$lines" ]; then
            lines=""
            while IFS= read -r zdir; do
                found=$(fd --type f -I -H -E .git -E .git-crypt -E .cache -E .backup -E .vscode "$1" "$zdir" 2>/dev/null)
                if [ -n "$found" ]; then
                    lines="$lines$found\n"
                fi
            done < <(zoxide query -l)
            lines="${lines%?}"
        fi

        if [ -z "$lines" ]; then
            echo "No matches found." >&2
            return
        fi

        line_count="$(echo "$lines" | wc -l | xargs)"
        if [ "$line_count" -eq 1 ]; then
            file="$lines"
        else
            file="$(echo -e "$lines" | fzf --query="$1" --height=70% --preview='bat -n --color=always --line-range :500 {}' --no-sort)"
        fi

        if [ -n "$file" ]; then
            dir="$(dirname "$file")"
            file_name="$(basename "$file")"
            cd "$dir" || { echo "Failed to cd to $dir" >&2; exit 1; }
            nvim "$file_name"
        fi
    fi
}

search_with_zoxide "$@"
