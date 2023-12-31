local actions = require("neogit.popups.remote.actions")
local util = require("neogit.lib.util")
local git = require("neogit.lib.git")
local popup = require("neogit.lib.popup")

local M = {}

-- TODO: Pass env here so you can remove a remote from refs view
function M.create(env)
  local p = popup
    .builder()
    :name("NeogitRemotePopup")
    :switch("f", "f", "Fetch after add", { enabled = true, cli_prefix = "-" })
    :config("u", "remote.origin.url")
    :config("U", "remote.origin.fetch")
    :config("s", "remote.origin.pushurl")
    :config("S", "remote.origin.push")
    :config("O", "remote.origin.tagOpt", {
      options = {
        { display = "", value = "" },
        { display = "--no-tags", value = "--no-tags" },
        { display = "--tags", value = "--tags" },
      },
    })
    :group_heading("Actions")
    :action("a", "Add", actions.add)
    :action("r", "Rename", actions.rename)
    :action("x", "Remove", actions.remove)
    :new_action_group()
    :action("C", "Configure...", actions.configure)
    :action("p", "Prune stale branches", actions.prune_branches)
    :action("P", "Prune stale refspecs")
    :action("b", "Update default branch")
    :action("z", "Unshallow remote")
    :env(util.merge({ highlight = { git.branch.pushRemote() } }, env))
    :build()

  p:show()

  return p
end

return M
