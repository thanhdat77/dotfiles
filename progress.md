# Progress

## Status
In Progress

## Tasks
- Rewrote `mini-basics.md`, `mini-bracketed.md`, `mini-bufremove.md`, `mini-clue.md`, `mini-cmdline.md`, `mini-deps.md` with repo-doc based concise structure.
- Rewrote `mini-diff.md`, `mini-extra.md`, `mini-files.md`, `mini-git.md`, `mini-input.md` with the same structure.
- Rewrote `mini-jump.md`, `mini-jump2d.md`, `mini-misc.md`, `mini-pick.md` with the same structure.
- Kept validation notes tied to current `nvim-mini` config only.
- Preserved conservative notes for modules not loaded or not directly validated at runtime.

## Files Changed
- docs/kickstart-mini/usecases/mini-basics.md
- docs/kickstart-mini/usecases/mini-bracketed.md
- docs/kickstart-mini/usecases/mini-bufremove.md
- docs/kickstart-mini/usecases/mini-clue.md
- docs/kickstart-mini/usecases/mini-cmdline.md
- docs/kickstart-mini/usecases/mini-deps.md
- docs/kickstart-mini/usecases/mini-diff.md
- docs/kickstart-mini/usecases/mini-extra.md
- docs/kickstart-mini/usecases/mini-files.md
- docs/kickstart-mini/usecases/mini-git.md
- docs/kickstart-mini/usecases/mini-input.md
- docs/kickstart-mini/usecases/mini-jump.md
- docs/kickstart-mini/usecases/mini-jump2d.md
- docs/kickstart-mini/usecases/mini-misc.md
- docs/kickstart-mini/usecases/mini-pick.md
- progress.md

## Notes
- Validation facts came from `/home/fenix/.config/nvim-mini/lua/plugins/mini.lua` and current headless mapping/option checks.
- `mini.extra`, `mini.input`, `mini.cmdline`, and `mini.deps` are documented from repo docs only; runtime not loaded in current config.
- `mini.clue` is called in config but has no trigger/clue config there, so clue window runtime is not claimed validated.
- `mini.misc` is only validated as loaded/setup in current config; helper functions were not exhaustively exercised.
- `mini.jump` and `mini.pick` were validated against current mappings; `mini.jump2d` was validated against custom `s` mapping.
- `mini.git` remains conservative: module loaded, but `:Git` is not claimed validated in current runtime checks.
