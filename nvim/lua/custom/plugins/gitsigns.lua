return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {}
      vim.keymap.set('n', '<leader>g', '<cmd>Gitsigns blame<CR>', { desc = '[G]itsigns blame' })
    end,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
