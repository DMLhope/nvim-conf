local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - 必须指定一个代码片段引擎
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- 适用于 `luasnip` 用户.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- 使用 <C-b/f> 来滚动文档
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- 使用 <C-k/j> 来在选项之间切换
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- 使用 <CR>（回车）来确认选择
        -- 接受当前选定的条目。将 `select` 设置为 `false` 仅确认显式选定的条目。
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- 超级 Tab
        -- 来源：https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- 提示：如果完成菜单可见，则选择下一个
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }), -- i - 插入模式；s - 选择模式
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

  -- 让我们配置条目的外观
  -- 来源：https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
  formatting = {
      -- 从左到右设置顺序
      -- kind: 表示补全类型的单个字母
      -- abbr: "word" 的缩写；当不为空时，在菜单中使用它而不是 "word"
      -- menu: 弹出菜单的额外文本，显示在 "word" 或 "abbr" 之后
      fields = { 'abbr', 'menu' },

      -- 自定义完成菜单的外观
      format = function(entry, vim_item)
          vim_item.menu = ({
              nvim_lsp = '[Lsp]',
              luasnip = '[Luasnip]',
              buffer = '[File]',
              path = '[Path]',
          })[entry.source.name]
          return vim_item
      end,
  },

  -- 设置源的优先级
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },    -- 用于 nvim-lsp
    { name = 'luasnip' },     -- 适用于 luasnip 用户
    { name = 'buffer' },      -- 用于缓冲区单词补全
    { name = 'path' },        -- 用于路径补全
  })
})