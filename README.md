# nvim-config

Neovim configuration files

## Windows

> [!WARNING]
> On Windows, treesitter parsers are compiled with MSVC (`cl.exe`).
> Large parsers (e.g. `gitcommit`) take several minutes to compile with optimizations,
> so this config disables optimizations (`_CL_=/Od`) while installing parsers automatically.
> Parsers installed with `:TSInstall` or `:TSUpdate` are still compiled with optimizations.
>
> If Neovim exits during a build, the compiler may keep running and lock the cache,
> and the next install fails with `Could not rename temp: EPERM: operation not permitted`.
> In that case, close all Neovim instances and run the following in PowerShell:
>
> ```powershell
> # 1. Stop the remaining build processes
> Get-Process cl, link, tree-sitter -ErrorAction SilentlyContinue | Stop-Process -Force
> # 2. Remove the cache (`:echo stdpath('cache')` shows its location)
> Remove-Item -Recurse -Force "$env:TEMP\nvim\tree-sitter-gitcommit", "$env:TEMP\nvim\tree-sitter-gitcommit-tmp" -ErrorAction SilentlyContinue
> ```
>
> Then restart Neovim, and the parser is installed automatically.
> If the cache still cannot be removed, antivirus software may be locking it: retry later or after a reboot.
