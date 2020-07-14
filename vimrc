"--------------------------------------------"
"
" VIM定制，打造个性IDE
" 2020-07-01
"
"--------------------------------------------"
filetype plugin on   "检测文件类型，并加载文件类插件“
set encoding=utf-8  "使用 utf-8 编码"
""
"添加待安装的插件"
""
call plug#begin('~/.vim/plugged')
"替代taglist，更加智能
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
"代码片段"
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'tianzong2019/vim-snippets' "massive common snippets
call plug#end()

set t_Co=256         "开启256色阶"
set cursorline       "突出显示当前行"
set cursorcolumn     "高亮显示光标列"
highlight cursorline cterm=none ctermbg=236     "配置高亮行背景颜色"
highlight cursorcolumn cterm=none ctermbg=236

syntax on
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>    "用< F2>开启/关闭行号

set ignorecase smartcase  "搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感"
set incsearch  "输入搜索内容时就显示搜索结果"
set hlsearch   "搜索时高亮显示被找到的文本"
set noerrorbells "关闭错误信息响铃"

set nobackup    "覆盖文件时不备份"
set noswapfile

set shiftwidth=4            "设定 << 和 >> 命令移动时的宽度为 4"
set softtabstop=4           "使得按退格键时可以一次删掉 4 个空格"
set tabstop=4               "设定 tab 长度为 4"

set magic                  "显示括号配对情况
set hidden                 "允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set pastetoggle=<F7>       "在粘贴代码之前，进入insert模式，按F7,就可以关闭自动缩进"


"-------------------------------------------------"
"配置折叠方式
"
"  zc 关闭折叠
"  zo 打开折叠
"  za 打开/关闭折叠互相切换
"
"-------------------------------------------------"
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码
"set foldclose=all          " 设置为自动关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠



"-------------------------------------------------"
"
"括号自动补全"
"
"-------------------------------------------------"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i



"-------------------------------------------------"
"
"窗口移动及resize"
"
"-------------------------------------------------"
nnoremap <c-h>    <esc><c-w>h<esc>
nnoremap <c-j>    <esc><c-w>j<esc>
nnoremap <c-k>    <esc><c-w>k<esc>
nnoremap <c-l>    <esc><c-w>l<esc>

nnoremap <M-left>    <esc><c-w>h<esc>
nnoremap <M-down>    <esc><c-w>j<esc>
nnoremap <M-up>    <esc><c-w>k<esc>
nnoremap <M-right>    <esc><c-w>l<esc>

nmap v=    <esc>:resize +3<cr><esc>
nmap v-    <esc>:resize -3<cr><esc>
nmap v,    <esc>:vertical resize +3<cr><esc>
nmap v.    <esc>:vertical resize -3<cr><esc>


"-------------------------------------------------"
"
"最大化当前窗口及返回
"
"-------------------------------------------------"
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction
nnoremap zx <esc>:call Zoom() <cr><esc>


"-------------------------------------------------"
"quickfix
"F8 打开隐藏
"
"-------------------------------------------------"
let g:quickfixname=1
function! QuickfixFunc()
	if g:quickfixname
		let g:quickfixname=0
		exec ":copen 20"
	else
		let g:quickfixname=1
		exec ":ccl"
	endif
endfunction
nnoremap <F8> <esc>:call QuickfixFunc() <cr><esc>


"-------------------------------------------------"
"tagbar代替taglist
"F4 打开隐藏
"
"-------------------------------------------------"
let g:tagbar_width=30                   "窗口宽度的设置
map <F4> :Tagbar<CR>


"-------------------------------------------------"
"winmanager配置
"F3 打开隐藏nerdtree
"
"-------------------------------------------------"
let g:NERDTreeHidden=0     "不显示隐藏文件
map <F3> <esc>:NERDTreeMirror<CR><esc>
map <F3> <esc>:NERDTreeToggle<CR><esc>


"-------------------------------------------------"
"NERD Commenter,注释工具
"
"默认<leader>是逗号‘，’
"<leader>cc   加注释
"<leader>cu   解开注释
"<leader>c<space>  加上/解开注释, 智能判断
"<leader>cy        先复制, 再注解(p可以进行黏贴))>>>>>
"-------------------------------------------------"
let g:NERDSpaceDelims=1  "注释符号后面空一格


"-------------------------------------------------"
"CtrlP配置
"
"ctrl + j/k 进行上下选择
"ctrl + x 在当前窗口水平分屏打开文件
"ctrl + v 同上, 垂直分屏
"ctrl + t 在tab中打开
"
"-------------------------------------------------"
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


"-------------------------------------------------"
"ctags配置
"
"
"-------------------------------------------------"
set tags=tags;
set autochdir


"-------------------------------------------------"
"cscope配置
"
"
"-------------------------------------------------"
if has("cscope")  
    set csprg=/usr/bin/cscope  
    set csto=0 
    set cst  
    set csverb  
    set cspc=3 
    "add any database in current dir  
    if filereadable("cscope.out")  
        cs add cscope.out  
    "else search cscope.out elsewhere  
    else 
        let cscope_file=findfile("cscope.out",".;")  
        let cscope_pre=matchstr(cscope_file,".*/")  
        if !empty(cscope_file) && filereadable(cscope_file)  
            exe "cs add" cscope_file cscope_pre  
        endif        
    endif  
	"------------------ cscope key maping
	"
	" s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
	" g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
	" d: 查找本函数调用的函数
	" c: 查找调用本函数的函数
	" t: 查找指定的字符串
	" e: 查找egrep模式，相当于egrep功能，但查找速度快多了
	" f: 查找并打开文件，类似vim的find功能
	" i: 查找包含本文件的文件
	"
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	nmap qs :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap qg :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap qd :cs find d <C-R>=expand("<cword>")<CR><CR> 
	nmap qc :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap qt :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap qe :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap qf :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap qi :cs find i ^<C-R>=expand("<cfile>")<CR>{1}lt;CR>
endif





