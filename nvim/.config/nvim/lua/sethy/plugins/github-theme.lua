return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                transparent = false,
            },
        })
        --vim.cmd("colorscheme github_light")
        -- alternatives:
        -- vim.cmd("colorscheme github_light_default")
        -- vim.cmd("colorscheme github_light_colorblind")
    end,
}

