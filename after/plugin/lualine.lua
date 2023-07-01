require("lualine").setup({
  sections = {
    -- lualine_b = { "grapple" },
    lualine_c = {{ 'filename', path = 1 }},
  },
  inactive_sections = {
    -- lualine_b = { "grapple" },
    lualine_c = {{ 'filename', path = 1 }},
  }
})


