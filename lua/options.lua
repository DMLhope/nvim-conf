-- 使用系统剪贴板
vim.opt.clipboard = 'unnamedplus'

-- 自动完成选项
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- 允许使用鼠标
vim.opt.mouse = 'a'

-- Tab 相关设置
vim.opt.tabstop = 4      -- 每个制表符的可视空格数
vim.opt.softtabstop = 4  -- 编辑时的制表符宽度
vim.opt.shiftwidth = 4   -- 制表符的空格数
vim.opt.expandtab = true -- 制表符转换为空格，主要用于 Python

-- 用户界面配置
vim.opt.number = true       -- 显示绝对行号
vim.opt.relativenumber = false  -- 在左侧每行添加行号
-- vim.opt.cursorline = true -- 在光标下方水平高亮显示当前行
vim.opt.splitbelow = true  -- 新建垂直分割时在底部打开
vim.opt.splitright = true  -- 新建水平分割时在右侧打开
-- vim.opt.termguicolors = true -- 在 TUI 中启用 24 位 RGB 颜色
vim.opt.showmode = false    -- 不显示插入模式提示 "-- INSERT --"

-- 搜索相关设置
vim.opt.incsearch = true    -- 输入字符时进行增量搜索
vim.opt.hlsearch = false    -- 不高亮显示匹配项
vim.opt.ignorecase = true   -- 默认忽略大小写进行搜索
vim.opt.smartcase = true    -- 但如果输入的是大写字母，则区分大小写