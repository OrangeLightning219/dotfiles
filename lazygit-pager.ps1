#!/usr/bin/env pwsh

$old = $args[1].Replace('\', '/')
$new = $args[4].Replace('\', '/')
$path = $args[0]
git diff --no-index --no-ext-diff $old $new
  | %{ $_.Replace($old, $path).Replace($new, $path) }
  | delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}" --width=$env:LAZYGIT_COLUMNS --diff-so-fancy --features="mellow-barbet" --syntax-theme="rose_pine"