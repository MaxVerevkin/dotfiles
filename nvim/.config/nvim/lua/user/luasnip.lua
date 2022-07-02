local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.expand_conditions"

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
}

vim.keymap.set({ "i", "s" }, "<c-n>", function()
  vim.notify(vim.inspect(ls.expand_or_jumpable()))
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- TODO: learn how to write snippets
-- ls.add_snippets("lua", {
--   s(
--     "req",
--     fmt(
--       'local status_ok_{}, {} = pcall(require, "{}")\nif not status_ok_{} then\n  return\nend',
--       { i(1, "module_name"), rep(1), rep(1), rep(1) }
--     )
--   ),
-- })
--
-- ls.add_snippets("rust", {
--   s(
--     "modtest",
--     fmt(
--       [[
--       #[cfg(test)]
--       mod tests {{
--       {}
--           {}
--       }}
--       ]],
--       {
--         c(1, { t "    use super::*;", t "" }),
--         i(0),
--       }
--     )
--   ),
-- })
