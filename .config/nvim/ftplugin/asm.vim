"map <F5> :wall!<CR>:!nasm -felf64 % && ld -o %:r %:r.o && ./%:r<CR>
"map <F5> :wall!<CR>:!yasm -f bin -o %:r.bin % && qemu-system-x86_64 %:r.bin<CR>
map <F5> :wall!<CR>:!nasm -f bin -o %:r.com % && ls -l %:r.com && dosbox %:r.com<CR>
