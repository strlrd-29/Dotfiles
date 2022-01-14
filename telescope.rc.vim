nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').file_browser()<cr>

lua << EOF
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
	file_ignore_patterns = {"node_modules", "yarn.lock"},
  }
}
EOF
