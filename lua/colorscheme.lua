-- define your colorscheme here
-- local colorscheme = 'monokai_ristretto'
local colorscheme = 'tokyonight-storm'
-- local colorscheme = 'catppuccin-frappe'
-- local colorscheme = 'catppuccin-latte'
-- local colorscheme = 'monokai_pro'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
