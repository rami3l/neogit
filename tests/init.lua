local util = require("tests.util.util")

if os.getenv("CI") then
  local tmp_dir = vim.fn.tempname():match("(.*)/[^/]$") .. "/"
  -- vim.opt.runtimepath:prepend(vim.fn.getcwd())
  util.ensure_installed("nvim-lua/plenary.nvim", tmp_dir)
else
  util.ensure_installed("nvim-lua/plenary.nvim", util.neogit_test_base_dir)
end

require("plenary.test_harness").test_directory(
  os.getenv("TEST_FILES") == "" and "tests/specs" or os.getenv("TEST_FILES"),
  {
    minimal_init = "tests/minimal_init.lua",
    sequential = true,
  }
)

-- local M = {}
--
-- local base_root_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h") .. "/.min"
-- function M.root(path)
--   return base_root_path .. "/" .. (path or "")
-- end
--
-- function M.load_plugin(repo)
--   local package_root = M.root("plugins/")
--   local name = repo:match(".+/(.+)$")
--   local install_path = package_root .. name
--
--   vim.opt.runtimepath:append(install_path)
--
--   if not vim.loop.fs_stat(package_root) then
--     vim.fn.mkdir(package_root, "p")
--   end
--
--   if not vim.loop.fs_stat(install_path) then
--     print(("* Downloading %s to '%s/'"):format(name, install_path))
--     vim.fn.system { "git", "clone", "--depth=1", "git@github.com:" .. repo .. ".git", install_path }
--
--     if vim.v.shell_error > 0 then
--       error(string.format("! Failed to clone plugin: '%s' in '%s'!", name, install_path),
--         vim.log.levels.ERROR)
--     end
--   end
-- end
--
-- function M.setup(plugins)
--   vim.opt.packpath = {}                      -- Empty the package path so we use only the plugins specified
--   vim.opt.runtimepath:append(M.root(".min")) -- Ensure the runtime detects the root min dir
--
--   for _, name in ipairs(plugins) do
--     M.load_plugin(name)
--   end
--
--   vim.env.XDG_CONFIG_HOME = M.root("xdg/config")
--   vim.env.XDG_DATA_HOME = M.root("xdg/data")
--   vim.env.XDG_STATE_HOME = M.root("xdg/state")
--   vim.env.XDG_CACHE_HOME = M.root("xdg/cache")
-- end
--
-- M.setup({
--   "nvim-lua/plenary.nvim",
--   "nvim-telescope/telescope.nvim",
--   "sindrets/diffview.nvim",
-- })
--
-- local test_files = os.getenv("TEST_FILES") == "" and "tests/specs" or os.getenv("TEST_FILES")
-- require("plenary.test_harness").test_directory(test_files, {
--   sequential = true,
--   minimal_init = "tests/minimal_init.lua"
-- })
--
