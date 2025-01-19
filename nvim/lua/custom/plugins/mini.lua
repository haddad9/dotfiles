return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }
    require('mini.pairs').setup()
    require('mini.files').setup {
      options = {
        use_as_default_explorer = false,
      },
      mappings = {
        close = '<ESC>',
        go_in_plus = '<CR>', -- close explorer when open
        synchronize = 's',
        go_out_plus = 'h', -- default H
      },
    }

    -- File manager update height
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowUpdate',
      callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)

        -- Ensure fixed height
        config.height = 45

        -- Ensure title padding
        if config.title[#config.title][1] ~= ' ' then
          table.insert(config.title, { ' ', 'NormalFloat' })
        end
        if config.title[1][1] ~= ' ' then
          table.insert(config.title, 1, { ' ', 'NormalFloat' })
        end

        vim.api.nvim_win_set_config(args.data.win_id, config)
      end,
    })
    vim.api.nvim_create_user_command('MiniFilesOpen', function()
      MiniFiles.open(vim.fn.expand('#' .. vim.api.nvim_get_current_buf()), false)
    end, {})
    -- Map the command to keyboard bind
    vim.keymap.set({ 'n' }, '<leader>b', '<cmd>MiniFilesOpen<CR>', { desc = 'Open Directory [b] ' })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
