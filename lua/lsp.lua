require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- 要自动安装的服务器列表，如果它们尚未安装
    ensure_installed = { 'pylsp', 'lua_ls', 'rust_analyzer', 'bash_ls', 'gopls' },
})

-- 为不同的语言设置不同的 LSP 配置
-- LSP 列表: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- 如何使用 setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - settings 表将发送给 LSP
--     - on_attach: LSP 成功附加到给定缓冲区后运行的 Lua 回调函数
local lspconfig = require('lspconfig')

-- 自定义的 on_attach 函数
-- 有关下面函数的文档，请参阅 `:help vim.diagnostic.*`
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- 仅在语言服务器附加到当前缓冲区后使用 on_attach 函数来映射以下键
local on_attach = function(client, bufnr)
    -- 启用由 <c-x><c-o> 触发的自动完成
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- 有关下面函数的文档，请参阅 `:help vim.lsp.*`
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

-- 配置每个语言的 LSP
-- 如何为特定语言添加 LSP？
-- 1. 使用 `:Mason` 安装相应的 LSP
-- 2. 添加以下配置
lspconfig.pylsp.setup({
    on_attach = on_attach,
})

lspconfig.gopls.setup({
    on_attach = on_attach,
})

lspconfig.bashls.setup({
    on_attach = on_attach,
})

-- 来源：https://rust-analyzer.github.io/manual.html#nvim-lsp
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                -- 是否在关闭 } 后显示插入提示，指示它所属的项目。
                closingBraceHints= true,
            },
        },
    },
})

lspconfig.clangd.setup({
    on_attach = on_attach,
})

lspconfig.ocamllsp.setup({
    on_attach = on_attach,
})