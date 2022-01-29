local utils = require "utils"
local map = utils.map

-- Expand %% to the directory of the curent file.
map('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", {expr = true})

-- Bubble lines
map('n', '<C-k>', '[e')
map('n', '<C-j>', ']e')
map('v', '<C-k>', '[egv')
map('v', '<C-j>', ']egv')

-- Toggle search highlight.
map('n', '<Leader><Space>', '<Cmd>lua vim.o.hlsearch = not vim.o.hlsearch<CR>')

-- Add more undo-steps when writing prose.
for _, v in pairs({'.', '?', '!', ','}) do map('i', v, v .. '<C-g>u') end

-- Underline the current line with - or =.
map('n', '<Leader>-', '"ayy"ap:s/./-/g<CR>')
map('n', '<Leader>=', '"ayy"ap:s/./=/g<CR>')

-- Mark bulleted item as done
map('n', '+', ':s/^\\s*\\zs[-x~?]/+<CR>:w<CR>')

-- Save and restore sessions.
local sessions_dir = '~/.local/share/nvim/sessions/'
map('n', '<Leader>ss', ':mks! ' .. sessions_dir)
map('n', '<Leader>sr', ':so ' .. sessions_dir)

-- Edit snippets.
map('n', '<Leader>s', '<Cmd>UltiSnipsEdit<CR>')

-- Show syntax element under cursor.
map('n', '<F10>',
    '<Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . \'> trans<\' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>')
