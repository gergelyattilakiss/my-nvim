return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      diagnostics = {
        virtual_text = true,   -- Show inline error text
        underline = true,      -- Underline error locations
        severity_sort = true,  -- Sort by severity
        -- Add other vim.diagnostic.config() options here
      },
    },
  },
}
