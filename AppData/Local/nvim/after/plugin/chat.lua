local chat = require("CopilotChat")

chat.setup()

-- Quick chat with Copilot
vim.keymap.set("n", "<leader>ccq", function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
    end
end, {
    desc = "Quick chat with Copilot"
}
)

vim.keymap.set("n", "<leader>cch", function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
end, {
    desc = "CopilotChat - Help actions",
}
)
