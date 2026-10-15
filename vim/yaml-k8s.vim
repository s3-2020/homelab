" yaml-k8s.vim — Kubernetes / YAML workflow for (neo)vim
" Loaded from vimrc via `runtime yaml-k8s.vim` or sourced explicitly.
" Works in both Vim and Neovim.

" --- Indentation: YAML/k8s manifests are strict about 2-space indents ---
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=0:
autocmd FileType yaml setlocal autoindent

" --- YAML as the file type for common k8s file patterns ---
autocmd BufRead,BufNewFile *.yaml,*.yml setfiletype yaml

" --- Show Tabs and trailing whitespace — YAML breaks on both ---
autocmd FileType yaml setlocal list listchars=tab:»·,trail:·

" --- Folding by YAML structure (fold on indentation) ---
autocmd FileType yaml setlocal foldmethod=indent foldnestmax=3 foldlevelstart=0
" Fold everything to overview with zR/zM; jump with zj/zk

" --- Highlight tabs in YAML as errors (tabs break YAML) ---
autocmd FileType yaml match Error /\t/

" --- Align keys, keep comment leaders ---
autocmd FileType yaml setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" --- Quick keymaps (buffer-local, YAML only) ---
" <leader>a : apply the current file with kubectl (dry-run first with <leader>d)
autocmd FileType yaml nnoremap <buffer> <leader>a :w<CR>:!kubectl apply -f %<CR>
autocmd FileType yaml nnoremap <buffer> <leader>d :w<CR>:!kubectl apply -f % --dry-run=client -o yaml<CR>
" <leader>g : describe the resource under cursor via yq-style grep (best effort)
autocmd FileType yaml nnoremap <buffer> <leader>k :!kubectl get -f % -o wide<CR>

" --- Reload kubeconfig hint when switching contexts is not vim's job —
"     but show current context on YAML open so you KNOW what you touch ---
autocmd FileType yaml call s:ShowKubeContext()

function! s:ShowKubeContext() abort
  if executable('kubectl')
    let l:ctx = system('kubectl config current-context 2>/dev/null')
    if v:shell_error == 0 && !empty(l:ctx)
      echohl ModeMsg
      echo '[kube] context: ' . trim(l:ctx)
      echohl None
    endif
  endif
endfunction
