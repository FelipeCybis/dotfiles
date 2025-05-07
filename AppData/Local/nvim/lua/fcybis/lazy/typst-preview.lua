return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  build = function()
    require("typst-preview").update()
  end,
  config = function()
    local mason_registry = require("mason-registry")
    local tinymist = mason_registry.get_package("tinymist")
    local tinymist_bin = tinymist:get_install_path()
    if vim.fn.has('win32') == 1 then
      tinymist_bin = tinymist_bin .. "/tinymist-win32-x64.exe"
    elseif vim.loop.os_uname().sysname == "Linux" then
      tinymist_bin = tinymist_bin .. "/tinymist-linux-x64"
    else
      tinymist_bin = tinymist_bin .. "/tinymist-darwin-x64"
    end

    require("typst-preview").setup({
      debug = false,
      -- invert_colors = "always",
      dependencies_bin = {
        ["tinymist"] = tinymist_bin,
      },
      get_main_file = function(path)
        -- I set this when pinning the typst main file
        -- if not, do what is the default
        if vim.g.typst_main_file then
          return vim.g.typst_main_file
        end
        return path
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "typst",
      callback = function()
        vim.schedule(function()
          vim.keymap.set("n", "<leader>ut", "<CMD>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview", buffer = 0 })
        end)
      end
    })
  end,
}
