return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        -- Show gitignored files/folders (e.g. nested repos in monorepo/workspace setups)
        hide_gitignored = false,
      },
    },
  },
}
