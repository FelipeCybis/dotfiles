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
      tinymist = tinymist .. "/tinymist-win32-x64.exe"
    elseif vim.loop.os_uname().sysname == "Linux" then
      tinymist = tinymist .. "/tinymist-linux-x64"
    else
      tinymist = tinymist .. "/tinymist-darwin-x64"
    end

    require("typst-preview").setup({
      debug = true,
      dependencies_bin = {
        ["tinymist"] = tinymist_bin,
      }
    })
  end,
}
