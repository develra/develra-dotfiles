if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/michaelaaron/.config/nvim/init.vim'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/michaelaaron/.vim/dein'
let g:dein#_runtime_path = '/home/michaelaaron/.vim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/home/michaelaaron/.vim/dein/.cache/init.vim'
let &runtimepath = '/home/michaelaaron/.config/nvim,/etc/xdg/nvim,/home/michaelaaron/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/home/michaelaaron/.vim/dein/repos/github.com/Shougo/dein.vim,/home/michaelaaron/.vim/dein/.cache/init.vim/.dein,/usr/local/share/nvim/runtime,/home/michaelaaron/.vim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/home/michaelaaron/.local/share/nvim/site/after,/etc/xdg/nvim/after,/home/michaelaaron/.config/nvim/after'
filetype off
