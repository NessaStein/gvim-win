" 启动设置 {{{
source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/vimrc_example.vim
set nocompatible
behave mswin
" Windows下启动自动全屏
"au GUIEnter * simalt ~x
" 启动的时候不显示那个援助索马里儿童的提示
autocmd GUIEnter * set shortmess=atI
"打开filetype自动功能
filetype indent plugin on

" 关闭foldmethod
set nofoldenable
" vim 文件折叠方式为marker 打开折叠导致C-p补全变卡
"augroup ft_vim
"    au!
"
"    autocmd filetype vim setlocal foldmethod=marker
"augroup END
" }}}

" 通用设置 {{{

" 在处理未保存或只读文件的时候，弹出确认
set confirm
"设置显示行号
set nu

" 取消备份文件，swap文件，undo文件
set nobackup
set noswapfile
set noundofile

" 保存历史纪录
set history=2048
" 自动设置目录为正在编辑的文件所在的目录
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no

" 在搜索的时候忽略大小写
set ignorecase
" }}}

" 语言编码设置 {{{

" 中文编码设置cp936是windows默认编码
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
" 开始帮助页面中文
language messages zh_CN.UTF-8
"解决consle输出乱码
"if has("win32")
"set fileencoding=chinese
"else
"set fileencoding=utf-8
"endif
" }}}

" GUI {{{
colorscheme desert

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set cursorline
set hlsearch
set number
" 窗口大小
" set lines=35 columns=140
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
set nolist
" set listchars=tab:▶\ ,eol:¬,trail:·,extends:>,precedes:<

" 设置字体
if has('win32')
    set guifont=Consolas:h14:cANSI   " Win32.
elseif has('gui_macvim')
    set guifont=Monaco:h14     " OSX.
else
    set guifont=Monospace\ 12  " Linux.
endif
" }}}

" 格式化 {{{
set autoindent
set smartindent
set tabstop=4
set sts=4
set shiftwidth=4
set cindent
set expandtab
set softtabstop=4
set foldmethod=indent
syntax on
" }}}

" 基本快捷键 {{{
let mapleader=","

nmap <leader>s :source $HOME/_vimrc<cr>
nmap <leader>e :e $HOME/_vimrc<cr>

" 正常模式下 Meta-t Meta-x操作tab
nnoremap <C-t> :tabnew<cr>
" C-w被占用，使用C-x
nnoremap <C-x> :tabclose<cr>
" 使用c-tab循环切换tab
map <C-Tab> :tabn<cr>

" 窗口移动
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>

"切换自动换行
nnoremap <leader>wrap :set wrap!<cr>

" windows C-c C-v复制粘贴
imap <C-v> "+gP
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
imap <C-V>        "+gP
map <S-Insert>        "+gP
cmap <C-V>        <C-R>+
cmap <S-Insert>        <C-R>+

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" 打开当前目录 windows
map <leader>ex :!start explorer %:p:h<CR>
" 打开当前目录CMD
map <leader>cmd :!start cmd<cr>
" 打开当前powershell
map <leader>ps :!start powershell<cr>
" 打印当前时间
map <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>

" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

" 根据文件类型来运行
autocmd FileType python nnoremap <buffer> <F12> :!python % <CR>
autocmd FileType ps1 nnoremap <buffer> <F12> :!powershell -file % <CR>

""设置运行python代码的快捷键，绑定到F12按键上
"map <F12> :!c:\Python27\python.exe %<CR>
imap jj <Esc>
" insert模式直接C-l到最后插入
imap <C-l> <Esc>$a
"删除当前文件行尾的空格
map <leader>cls :%s/\s\+$//g<CR>

" windows下C-v块选择
unmap <C-V>
nunmap <C-A>
" }}}

" 插件安装{{{
" vim-plug setttings
call plug#begin('$HOME/vimfiles/plugged')
" Plug放在中间
Plug 'scrooloose/nerdtree' "目录浏览插件
Plug 'ivalkeen/nerdtree-execute' "目录浏览插件-用默认程序执行
Plug 'rakr/vim-one'   "主题
"Plug 'kien/ctrlp.vim' "搜索
Plug 'majutsushi/tagbar' "Tagbar
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive' " git插件
Plug 'ntpeters/vim-better-whitespace' "句尾空行显示
Plug 'pprovost/vim-ps1' "powershell语法高亮
Plug 'fidian/hexmode'    "二进制插件
" Plug放在中间
call plug#end()
" }}}

" 插件相关配置及快捷键 {{{
" 切换NerdTree
"map <C-n> :NERDTreeToggle<CR>
" 打开NerdTree并选中当前文件，按q推出
nmap <C-n> :NERDTreeFind<CR>
" 主题配置
colorscheme one
" set background=dark " for the dark version
" set background=light " for the light version
" let g:airline_theme='one'

" TagBar快捷键
nmap <F8> :TagbarToggle<CR>
" 二进制编辑模式切换
map <leader>hm :Hexmode<CR>
"let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
"let g:hexmode_xxd_options = '-g 1'

" fzf快捷键 emacs style
"nnoremap <silent> <C-s><C-b> :Buffers<CR>
"nnoremap <silent> <C-s><C-f> :Files<CR>
"nnoremap <silent> <C-s><C-w> :Windows<CR>
"nnoremap <silent> <C-s><C-l> :Lines<CR>   "Search Lines in all buffer
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>l :Lines<CR>
"open recent file
map <leader>r :History<CR>
map <leader>win :Windows<CR>
" }}}
