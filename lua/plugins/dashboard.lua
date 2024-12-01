return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {

        sections = {
          {
            section = "terminal",
            cmd = "pokemon-colorscripts -n gengar --no-title; sleep .1",
            pane = 1,
            padding = 1,
            height = 18,
          },
          { section = "keys", padding = 1, gap = 1, pane = 2, title = "Menu" },
          { section = "startup", padding = 1, pane = 2 },
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {

              {
                title = "Open Issues",
                cmd = "gh issue list -L 3",
                icon = " ",
                height = 5,
              },
              {
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                height = 5,
              },
              {
                icon = " ",
                title = "Git Status",
                cmd = "hub --no-pager diff --stat -B -M -C",
                height = 5,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 3,
                section = "terminal",
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
        },
      },
    },
  },
}
