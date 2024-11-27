local LuaSnip = {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    -- TJ's luasnippet setup
    -- https://github.com/tjdevries/config.nvim/blob/37c9356fd40a8d3589638c8d16a6a6b1274c40ca/lua/custom/snippets.lua

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.active = function(filter)
      filter = filter or {}
      filter.direction = filter.direction or 1

      if filter.direction == 1 then
        return ls.expand_or_jumpable()
      else
        return ls.jumpable(filter.direction)
      end
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.jump = function(direction)
      if direction == 1 then
        if ls.expandable() then
          return ls.expand_or_jump()
        else
          return ls.jumpable(1) and ls.jump(1)
        end
      else
        return ls.jumpable(-1) and ls.jump(-1)
      end
    end

    vim.snippet.stop = ls.unlink_current

    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      override_builtin = true,
    })

    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
      loadfile(ft_path)()
    end

    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
    end, { silent = true })
  end
}

local M = {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    LuaSnip,
    'saghen/blink.compat',
    'saadparwaiz1/cmp_luasnip',
  },

  build = 'cargo build --release',
  config = function()
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {
      keymap = {
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-.>'] = { 'hide', 'show', 'fallback' }
      },

      accept = {
        expand_snippet = require('luasnip').lsp_expand
      },

      trigger = {
        completion = {
          show_on_insert_on_trigger_character = false,
        }
      },

      windows = {
        autocomplete = {
          border = 'single',
          auto_show = true,
          selection = 'auto_insert'
        },
        documentation = {
          border = 'single',
          auto_show = true,
        }
      },

      sources = {
        completion = {
          sources = {
            "lsp",
            "path",
            "buffer",
            "luasnip"
          },
        },
        providers = {
          buffer = {
            min_keyword_length = 4
          },

          snippets = {
            min_keyword_length = 2
          },

          luasnip = {
            name = 'luasnip',
            module = 'blink.compat.source',

            opts = {
              use_show_condition = false,
              show_autosnippets = true,
            },
          },
        },
      },

      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = 'mono',
    }

    require('blink.cmp').setup(opts)
  end
}

return M
