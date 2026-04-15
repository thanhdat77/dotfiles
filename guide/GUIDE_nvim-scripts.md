# nvim Scripts Guide

Custom scripts for fuzzy finding files and opening them in nvim.

---

## `nf [query]` — find by file name

Fuzzy searches file names across current dir + sesh sessions + zoxide dirs.

```bash
nf          # browse all files
nf main     # pre-fill search with "main"
```

- Preview: `bat` with syntax highlighting
- Opens selected file in nvim

---

## `nr [query]` — find by content

Fuzzy searches file contents using ripgrep across current dir + sesh sessions + zoxide dirs.

```bash
nr              # browse all matches
nr "TODO"       # pre-fill search with "TODO"
```

- Preview: `bat` with the matched line highlighted
- Opens selected file in nvim at the exact matched line
