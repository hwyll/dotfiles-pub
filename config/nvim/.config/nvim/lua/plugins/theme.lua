-- return {
--   {
--     "rebelot/kanagawa.nvim",
--     opts = {
--       transparent = true,
--       theme = "dragon",
--       background = {
--         dark = "dragon",
--         light = "lotus",
--       },
--       colors = {
--         palette = {
--           -- change all usages of these colors
--           --- oldWhite = "#FFFFDD",
--           --- fujiWhite = "#FFFFFF",
--         },
--         theme = {
--           all = {
--             ui = {
--               bg_gutter = "none",
--             },
--           },
--         },
--       },
--       overrides = function(colors)
--         local theme = colors.theme
--         -- Only setup the only ones needed
--         --- vim.api.nvim_set_hl(0, "PopMenu", { bg = theme.ui.bg, blend = 0 })
--         return {
--           NormalFloat = { bg = "none" }, -- All floating buffers background like the lsp, autocomplete and such
--           FloatBorder = { bg = "none" }, -- Most floating borders except telescope
--           TelescopeBorder = { bg = "none" },
--         }
--       end,
--     },
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "kanagawa",
--     },
--   },
-- }

return {
  {
    "catppuccin",
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
      },
      flavour = "mocha",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
