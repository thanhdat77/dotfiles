return {
  "chipsenkbeil/distant.nvim",
  branch = "v0.3",
  cmd = { "DistantLaunch", "DistantConnect", "DistantOpen", "DistantShell" },
  config = function()
    require("distant"):setup({
      ["*"] = {
        launch = {
          -- use distant binary found on remote PATH
          bin = "distant",
          args = {},
        },
        connect = {
          default = {
            scheme = "ssh",
          },
        },
      },
    })
  end,
}
