-- VenvSelector
-- Pick python virtual environment from inside nvim

return {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
        require("venv-selector").setup({
            settings = {
                search = {
                    anaconda_base = {
                        command = "fd python$ /opt/homebrew/Caskroom/miniconda/base/envs --full-path",
                        type = "anaconda",
                    },
                },
            },
        })
        vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<CR>", { desc = "Select Python venv" })
        vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<CR>", { desc = "Select cached venv" })
    end,
}