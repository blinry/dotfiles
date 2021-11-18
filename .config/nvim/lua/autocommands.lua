vim.cmd([[autocmd bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zv' | let b:doopenfold = 1 | endif]]) -- When opening a file, always jump to the last known cursor position.
vim.cmd('au Vimresized * :wincmd =') -- Resize splits when the window is resized.
vim.cmd('au BufRead ~/permanent/wiki/* set ft=vimboy') -- Location of my private wiki.
vim.cmd('au BufRead,BufNewFile ~/permanent/pf2-wiki/* set ft=vimboy') -- Location of the Prototype Fund wiki.
vim.cmd([[syn match Special '---[-]*']]) -- Highlight second-level markdown headings properly.
vim.cmd('au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile') -- Don't create temporary files of gopass secrets.
