# vim — YAML / Kubernetes workflow

My (neo)vim configuration for working with Kubernetes manifests — used daily
on the jumphost (`jmp`) where all cluster administration happens.

## Files

| File | Purpose |
|---|---|
| `vimrc` | Base config: 2-space indentation, whitespace highlighting, syntax |
| `yaml-k8s.vim` | Kubernetes/YAML layer: folding, tab-errors, kubectl keymaps, context display |

## Install

Copy both files (or use them as dotfile templates):

```bash
mkdir -p ~/.vim  # or ~/.config/nvim for Neovim
cp vimrc ~/.vimrc
cp yaml-k8s.vim ~/.vim/  # and add `runtime yaml-k8s.vim` to your vimrc
```

Works in both Vim and Neovim — no plugins required.

## What you get

- 2-space YAML indentation, tabs highlighted as errors (tabs break YAML)
- Visible trailing whitespace (same reason)
- Indent-based folding — `zM` for full manifest overview, `zj`/`zk` to move
- Buffer-local keymaps: `<leader>a` apply, `<leader>d` client dry-run, `<leader>k` get
- Current kube context printed on every YAML open — so you always know which
  cluster you are touching
