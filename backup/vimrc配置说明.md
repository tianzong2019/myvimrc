# vimrc配置

- 高亮行列
- 搜索
- 不备份、不折叠
- tab键长度
- 状态栏
- 括号补全
- 窗口配置
- quickfix
- nerdtree
- nerdcommenter
- Bufexplorer
- 高亮插件mark.vim
- Ctrlp，对文件进行模糊的查找
- Taglist
- OmniComplete
- SuperTab，nan
- 代码片段UltiSnips
- ctags
- cscope

```shell
"=========================================================================
"
" 描述: 打造适合自己的vimrc
"
" 日期: 2020.12.23
"
" 版本: 0.2
"
"=========================================================================
filetype plugin on
set nocompatible            " 关闭 vi 兼容模式

set t_Co=256                " 开启256色阶
set cursorline              " 突出显示当前行
set cursorcolumn            " 高亮显示光标列
highlight cursorline cterm=none ctermbg=236     
highlight cursorcolumn cterm=none ctermbg=236
                            " 配置高亮行背景颜色

set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set noerrorbells            " 关闭错误信息响铃
set novisualbell            " 关闭使用可视响铃代替呼叫

set magic                   " 显示括号配对情况
syntax on                   " 自动语法高亮
set number                  " 显示行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
                            " 用< F2>开启/关闭行号

set nobackup                " 覆盖文件时不备份
set noswapfile

set shiftwidth=4            " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4               " 设定 tab 长度为 4

set pastetoggle=<F7>        " 在粘贴代码之前，进入insert模式，按F7,就可以关闭自动缩进
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
                            " 设置在状态行显示的信息

"---- 括号自动补全 ------------------------------------
"
"zc 关闭折叠
"zo 打开折叠
"za 打开/关闭折叠互相切换
"
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码
"set foldclose=all          " 设置为自动关闭折叠                
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠


"---- 括号自动补全 ------------------------------------
"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i


"---- 窗口移动及resize --------------------------------
"
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


"---- 最大化当前窗口及返回 ----------------------------
"
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


"---- F8 打开隐藏quickfix -----------------------------
"
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


"---- F3 打开隐藏nerdtree -----------------------------
" u 打开上层目录
"
let g:NERDTreeHidden=0                   " 不显示隐藏文件
map <F3> <esc>:NERDTreeMirror<CR><esc>
map <F3> <esc>:NERDTreeToggle<CR><esc>


"---- nerdcommenter -----------------------------
" [count]<leader>cc ：注释从当前行往下数的 count 行，count 可省略，默认值为 1
" \cc 注释当前行和选中行
" [count]<leader>cu：取消注释从当前行往下数的 count 行，count 可省略，默认值为1
"
let g:NERDSpaceDelims=1              " 注释的时候自动加个空格, 强迫症必配
let g:NERDCompactSexyComs=1          " 多行注释时，样子更好看


"---- Bufexplorer -----------------------------
"
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=1        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
let g:bufExplorerDisableDefaultKeyMapping =0 " Do not disable default key mappings.
nnoremap <silent> <F9> :ToggleBufExplorer<CR>  " F9打开关闭


"---- mark -----------------------------
"
" 基本用法：
" ：Mark <word>    查找并高亮显示；若已经高亮则查找并去掉高亮
" ：MarkClear        去除所有高亮
" 
" \m 高亮或反高亮一个单词
" \n 清除当前的单词高亮(光标处)若光标处无高亮的单词就清除所有的单词高亮显示
" \r 按照输入的正则表达式高亮单词
"  
" 搜索
" \* 跳转到当前高亮的下一个单词
" \# 跳转到当前高亮的上一个单词
" \/ 跳转到任一下一个高亮单词
" /? 跳转到任一上一高亮单词
"


"---- ctrlp -----------------------------
" :CtrlP 或 :CtrlP 路径 可以调用ctrlp并进入查找文件模式
" 按下 Esc 或 <Ctrl-c> 可退出ctrlp，返回到Vim窗口中
"
"<Leader>p搜索当前目录下文件
let g:ctrlp_map = '<c-p>'            " 在Vim 普通模式下，默认按下 <Ctrl>+p 即可打开ctrlp搜索窗口
let g:ctrlp_cmd = 'CtrlP'
"<Leader>f搜索MRU文件
nmap <Leader>f :CtrlPMRUFiles<CR>
"<Leader>b显示缓冲区文件，并可通过序号进行跳转
nmap <Leader>b :CtrlPBuffer<CR>
"设置搜索时忽略的文件
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_max_height = 15 "修改QuickFix窗口显示的最大条目数
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_max = 500 "设置MRU最大条目数为500
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_by_filename = 1 "默认使用全路径搜索，置1后按文件名搜索，准确率会有所提高，可以用<C-d>进行切换
let g:ctrlp_regexp = 0 "默认不使用正则表达式，置1改为默认使用正则表达式，可以用<C-r>进行切换
let g:ctrlp_line_prefix = '♪ ' "自定义搜索列表的提示符



"---- Tag list ----------------------------------------
"
let Tlist_Ctags_Cmd = '/usr/bin/ctags'   " Ctags可执行文件的路径，千万要写对了，否则显示no such file
let Tlist_Show_One_File = 1              " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1            " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Auto_Open=0                    " 打开文件时候不自动打开Taglist窗口
let Tlist_Use_Right_Window = 1           " 在右侧窗口中显示taglist窗口
map <F4> :TlistToggle<CR>


"---- OmniComplete 为 C/C++ 自动补全 ------------------
"
" 在插入模式编辑 C/C++ 源文件时按下 . 或 -> 或 ::，
" 或者手动按下 Ctrl+X Ctrl+O 后就会弹出自动补全窗口，
" 此时可以用 Ctrl+N 和 Ctrl+P 上下移动光标进行选择。
"
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1      " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1           " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1         " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1         " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest


"---- supertab ------------------
"
let g:SuperTabDefaultCompletionType="context" " supertab配置
let g:SuperTabMappingForward = "<s-tab>"
let g:SuperTabMappingBackward= "<s-tab>"


"---- UltiSnips 使用 tab 来触发代码片段补全 ---------------------
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"     " 使用 tab 切换下一个触发点，shit+tab 上一个触发点
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"           " 使用 UltiSnipsEdit 命令时垂直分割屏幕
"
if has('python')
	let g:UltiSnipsUsePythonVersion=2 "or 3
elseif has('python3')
	let g:UltiSnipsUsePythonVersion=3 "or 2
endif


"---- ctags配置 ---------------------------------------
"
set tags=tags;
set autochdir


"---- cscope配置 --------------------------------------
"
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
```

