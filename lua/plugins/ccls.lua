-- ~/.config/nvim/lua/user/plugins/ccls.lua
return {
  "ranjithshegde/ccls.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda" },
  dependencies = { "nvim-lua/plenary.nvim" },
}
