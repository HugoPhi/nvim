require "nvchad.options"

vim.o.cmdheight = 0
vim.o.scrolloff = 5
vim.o.relativenumber = true
vim.o.number = true
vim.o.autochdir = true
vim.o.cursorline = false
vim.o.wrap = false
vim.o.whichwrap = "b,s,<,>,[,]"
vim.o.sidescroll = 1
vim.o.sidescrolloff = 30
vim.g.indent_blankline_show_first_indent_level = true

-- 设置 TabLine 背景为透明
-- vim.cmd [[
--   highlight TabLine guibg=NONE
--   highlight TabLineFill guibg=NONE
--   highlight TabLineSel guibg=NONE
-- ]]

-- open last time
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

--indent styler
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = {
    "*.rs",
    "*.c",
    "*.cpp",
    "*.go",
    "*.java",
    "*.typst",
    "*.js",
    "*.py",
    "*.sh",
    "*.mysql",
  },
  callback = function()
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.lua", "*.json" },
  callback = function()
    vim.o.tabstop = 2
    vim.o.shiftwidth = 2
    vim.o.softtabstop = 2
    vim.o.expandtab = true
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     require("virt-column").setup {
--       char = ".",
--       virtcolumn = "100",
--     }
--   end,
-- })

-- Code Window
vim.api.nvim_set_hl(0, "CodewindowUnderline", {
  bg = "None",
  fg = "#FFFFFF",
  -- undercurl = true,  -- Underline style: curve
  underline = true,
})

-- cippboard
-- vim.g.clipboard = {
--   name = "WslClipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   paste = {
--     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }

-- Show Nvdash when all buffers are closed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- CMP
-- local cmp = require "cmp"
-- cmp.setup {
--   window = {
--     completion = {
--       border = { " ", " ", " ", " ", " ", " ", " ", " " },
--       winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
--       scrollbar = false,
--     },
--     documentation = {
--       border = { " ", " ", " ", " ", " ", " ", " ", " " },
--     },
--   },
-- }

-- neovide
if vim.g.neovide then
  -- vim.o.winblend = 50
  vim.o.guifont = "AnonymicePro Nerd Font:h12" -- text below applies for VimScript
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  -- vim.g.neovide_opacity = 0.9
end
