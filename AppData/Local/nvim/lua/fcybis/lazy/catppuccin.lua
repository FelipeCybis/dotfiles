return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require("catppuccin").setup({
            integrations = { harpoon = true, mason = true, which_key = true, blink_cmp = true },
            highlight_overrides = {
                frappe = function(frappe)
                    return {
                        ["@lsp.type.namespace.python"] = { fg = frappe.yellow },
                        Type = { fg = frappe.yellow, style = { "italic" } },
                        Function = { fg = frappe.blue, style = { "italic" } }
                    }
                end
            }
        })
        vim.cmd('colorscheme catppuccin-frappe')
    end
}
