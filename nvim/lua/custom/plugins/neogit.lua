return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'sindrets/diffview.nvim',
  },
  config = function()
    require('neogit').setup {
      integrations = {
        telescope = nil,
        diffview = false,
        fzf_lua = nil,
        mini_pick = nil,
      },
      kind = 'replace',
    }
  end,
}
