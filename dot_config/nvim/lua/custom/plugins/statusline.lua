-- Tabline + statusline matching the "numbered buffer tab" layout

local M = {}

---------------------------------------------------------------------
-- TABLINE (top bar: numbered box + buffer name)
---------------------------------------------------------------------

function M.tabline()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.fn.bufnr("%")
  local out = {}

  for i, buf in ipairs(bufs) do
    local name = vim.fn.fnamemodify(buf.name, ":t")
    name = name ~= "" and name or "[No Name]"
    local is_current = buf.bufnr == current

    if is_current then
      table.insert(out, "%#TabNumSel# " .. i .. " %#TabNameSel# " .. name .. " ")
    else
      table.insert(out, "%#TabNum# " .. i .. " %#TabName# " .. name .. " ")
    end
  end

  return table.concat(out) .. "%#TabFill#"
end

---------------------------------------------------------------------
-- STATUSLINE (bottom bar: mode | file | git | diagnostics ... filetype | pos | %)
---------------------------------------------------------------------

local mode_labels = {
  n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE",
  ["\22"] = "V-BLOCK", c = "COMMAND", R = "REPLACE",
  t = "TERMINAL", s = "SELECT",
}

local function git_branch()
  local branch = vim.b.gitsigns_head
  return (branch and branch ~= "") and branch or nil
end

local function diag_counts()
  local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  return err, warn, info
end

function M.statusline()
  local mode = vim.api.nvim_get_mode().mode
  local label = mode_labels[mode] or mode:upper()

  local filename = vim.fn.expand("%:t")
  filename = filename ~= "" and filename or "[No Name]"

  local branch = git_branch()
  local err, warn, info = diag_counts()

  local left = {
    "%#StlMode# " .. label .. " ",
    "%#StlNormal# " .. filename .. " ",
  }
  if branch then
    table.insert(left, "%#StlSub#" .. branch .. " ")
  end
  table.insert(left, string.format(
    "%%#StlSub#● %d  ✓ %d  ○ %d ",
    err, info, warn
  ))

  local ft = vim.bo.filetype ~= "" and vim.bo.filetype or "text"
  local right = string.format(
    "%%#StlSub#%s  %%l:%%c  %%P ",
    ft
  )

  return table.concat(left) .. "%=" .. right
end

---------------------------------------------------------------------
-- HIGHLIGHTS (neutral placeholders — restyle freely)
---------------------------------------------------------------------

local function set_highlights()
  vim.api.nvim_set_hl(0, "StlMode",     { fg = "#000000", bg = "#e92bff", bold = true })
  vim.api.nvim_set_hl(0, "StlNormal",   { fg = "#dddddd", bg = "#191120" })
  vim.api.nvim_set_hl(0, "StlSub",      { fg = "#999999", bg = "NONE" })

  vim.api.nvim_set_hl(0, "TabNumSel",   { fg = "#000000", bg = "#31748f", bold = true })
  vim.api.nvim_set_hl(0, "TabNameSel",  { fg = "#ffffff", bg = "#191120", bold = true })
  vim.api.nvim_set_hl(0, "TabNum",      { fg = "#666666", bg = "NONE" })
  vim.api.nvim_set_hl(0, "TabName",     { fg = "#666666", bg = "NONE" })
  vim.api.nvim_set_hl(0, "TabFill",     { bg = "NONE" })
end

set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function() vim.cmd("redrawstatus") end,
})

_G.Statusline = M

vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.Statusline.tabline()"
vim.opt.laststatus = 2
vim.opt.statusline = "%!v:lua.Statusline.statusline()"

return M
