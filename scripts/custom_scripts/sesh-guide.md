# Sesh — Tmux Session Manager

`sesh` is a modern CLI for managing tmux sessions. It replaces the old `tmux-sessionizer` script.

---

## Your Keybindings

| Key | Where | What it does |
|-----|-------|--------------|
| `prefix + f` | Inside tmux | Open fzf popup to pick/create a session |
| `ts` | Terminal | Same thing from the command line |

---

## Basic Usage

### Connect to a session
```bash
sesh connect myproject     # connect by name (creates it if it doesn't exist)
sesh connect ~/workspace/myproject  # connect using a path
```

### List all sessions
```bash
sesh list                  # all: running sessions + zoxide dirs + configs
sesh list -t               # only running tmux sessions
sesh list -z               # only zoxide directories
sesh list -c               # only sesh config sessions
```

### Disconnect / kill
```bash
sesh kill myproject        # kill a session by name
```

---

## The fzf Picker (`prefix + f`)

When you press `prefix + f` a popup appears showing all available sessions.
It lists three groups:

1. **Running sessions** — already open tmux sessions (switch instantly)
2. **Zoxide dirs** — directories you visit often (creates a new session)
3. **Config sessions** — sessions defined in `~/.config/sesh/sesh.toml`

Type to fuzzy filter, `Enter` to connect.

---

## Config File (optional)

You can predefine named sessions in `~/.config/sesh/sesh.toml`:

```toml
[[session]]
name = "dotfiles"
path = "~/dotfiles"
startup_command = "nvim ."

[[session]]
name = "workspace"
path = "~/workspace"
```

Then `sesh connect dotfiles` always opens nvim in your dotfiles — no matter where you are.

---

## Common Workflow

```
# From terminal: jump to a project
ts

# Inside tmux: fuzzy switch sessions
prefix + f

# Go directly to a known project
sesh connect dotfiles
```

---

## Tips

- Session names are based on the **directory basename** — `~/workspace/myapp` becomes `myapp`
- If a session already exists, `sesh connect` switches to it instead of creating a new one
- Combine with `prefix + o` (tmux-sessionx plugin) for even more session management options
