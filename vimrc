"=========================================================================
"
" 描述: 打造适合自己的vim IDE
"
" 日期: 2021.6.3
"
" 版本: 0.6
"
"
" 使用插件
"    lightline.vim-master
"    vim-mark-3.1.1
"    bufexplorer-7.4.21
"    nerdcommenter-2.5.2
"    The-NERD-tree-5.0.0
"    supertab-2.0
"    LeaderF-1.23            需要>vim7.4.330
"    UltiSnips-2.2
"    a.vim-2.18
"    taglist_46
"    Ctags 5.9
"    cscope 15.8b
"
"
" 升级vim
"    sudo add-apt-repository ppa:jonathonf/vim
"    sudo apt update 
"    sudo apt install vim
"    #删除源
"    sudo add-apt-repository -r ppa:jonathonf/vim
"=========================================================================
filetype plugin on
set nocompatible            " 配置不兼容vi

set pastetoggle=<F7>        " 在粘贴代码之前，进入insert模式，按F7,就可以关闭自动缩进

set nobackup                " 覆盖文件时不备份
set noswapfile
set noerrorbells            " 关闭错误信息响铃
set novisualbell            " 关闭使用可视响铃代替呼叫

set laststatus=2                                   "startup the lightline.vim
let g:lightline = { 'colorscheme': 'powerline', }  "set status-line
let g:Powerline_symbols= 'unicode'

set t_Co=256
set cursorline              " 突出显示当前行
set cursorcolumn            " 高亮显示光标列
highlight cursorline cterm=none ctermbg=236    
highlight cursorcolumn cterm=none ctermbg=236

set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
hi Search term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow

set magic                   " 显示括号配对情况
set number                  " 显示行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
                            " 用< F2>开启/关闭行号

syntax on                   " 自动语法高亮
set autoindent              "设置自动缩进：即每行的缩进值与上一行相等
set cindent                 "使用 C/C++ 语言的自动缩进方式

set shiftwidth=4            " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4               " 设定 tab 长度为 4



"""""""""""""""""""""""""""""""""""""""""""""""""
"配置代码折叠
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


"""""""""""""""""""""""""""""""""""""""""""""""""
"窗口移动及resize
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



"""""""""""""""""""""""""""""""""""""""""""""""""
"最大化当前窗口及返回
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



"""""""""""""""""""""""""""""""""""""""""""""""""
"vim-mark-3.1.1
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



"""""""""""""""""""""""""""""""""""""""""""""""""
"bufexplorer-7.4.21
"
"
"To start exploring in the current window, use: >
" <Leader>be   or   :BufExplorer   or   Your custom key mapping
"To toggle bufexplorer on or off in the current window, use: >
" <Leader>bt   or   :ToggleBufExplorer   or   Your custom key mapping
"To start exploring in a newly split horizontal window, use: >
" <Leader>bs   or   :BufExplorerHorizontalSplit   or   Your custom key mapping
"To start exploring in a newly split vertical window, use: >
" <Leader>bv   or   :BufExplorerVerticalSplit   or   Your custom key mapping



"""""""""""""""""""""""""""""""""""""""""""""""""
"nerdcommenter-2.5.2
"
"<leader>ca在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//  
"<leader>cc注释当前行
"<leader>c<space> 切换注释/非注释状态
"<leader>cs 以”性感”的方式注释
"<leader>cA 在当前行尾添加注释符，并进入Insert模式
"<leader>cu 取消注释
"<leader>c$ 从光标开始到行尾注释  ，这个要说说因为c$也是从光标到行尾的快捷键，这个按过逗号（，）要快一点按c$
"2<leader>cc 光标以下count行添加注释 
"2<leader>cu 光标以下count行取消注释
"2<leader>cm:光标以下count行添加块注释(2,cm)
"Normal模式下，几乎所有命令前面都可以指定行数
"Visual模式下执行命令，会对选中的特定区块进行注释/反注释
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1



"""""""""""""""""""""""""""""""""""""""""""""""""
"The-NERD-tree-5.0.0
"
" u 打开上层目录
"
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeHidden=0                   " 不显示隐藏文件
map <F3> <esc>:NERDTreeMirror<CR><esc>
map <F3> <esc>:NERDTreeToggle<CR><esc>



"""""""""""""""""""""""""""""""""""""""""""""""""
"SuperTab-0.41
"
let g:SuperTabDefaultCompletionType="context" " supertab配置
let g:SuperTabMappingForward = "<s-tab>"
let g:SuperTabMappingBackward= "<s-tab>"



"""""""""""""""""""""""""""""""""""""""""""""""""
"LeaderF-1.23
"
"
set encoding=utf-8
let &termencoding=&encoding
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1,gbk,gb2312
"navigate the result list just like `<C-K>` and `<C-J>`
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
" Show icons, icons are shown by default
let g:Lf_ShowDevIcons = 0
" For GUI vim, the icon font can be specify like this, for example
"let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"
" If needs
set ambiwidth=double
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
"  'fullScreen' - the LeaderF window take up the full screen
"  'top' - the LeaderF window is at the top of the screen.
"  'bottom' - the LeaderF window is at the bottom of the screen.
"  'left' - the LeaderF window is at the left of the screen.
"  'right' - the LeaderF window is at the right of the screen.
"  'popup' - the LeaderF window is a popup window or floating window.
"let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.repo', '.project', '.project2']
" 自定义
let g:Lf_WindowHeight = 0.30
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>



"""""""""""""""""""""""""""""""""""""""""""""""""
"UltiSnips 2.2
"
"
if has('python')
        let g:UltiSnipsUsePythonVersion=2
elseif has('python3')
        let g:UltiSnipsUsePythonVersion=3
endif
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



"""""""""""""""""""""""""""""""""""""""""""""""""
"a.vim-2.18
"
"
":A switches to the header file corresponding to the current file being edited
"(or vise versa)
":AS splits and switches
":AV vertical splits and switches
":AT new tab and switches
":AN cycles through matches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
":IHT new tab and switches
":IHN cycles through matches
"<Leader>ih switches to file under cursor
"<Leader>is switches to the alternate file of file under cursor (e.g. on
"<foo.h> switches to foo.cpp)
"<Leader>ihn cycles through matches
"
"E.g. if you are editing foo.c and need to edit foo.h simply execute :A and
"you will be editting foo.h, to switch back to foo.c execute :A again.



"""""""""""""""""""""""""""""""""""""""""""""""""
"taglist_4.6
"
"
let Tlist_Ctags_Cmd = '/usr/bin/ctags'   " Ctags可执行文件的路径，千万要写对了，否则显示no such file
let Tlist_Show_One_File = 1              " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1            " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Auto_Open=0                    " 打开文件时候不自动打开Taglist窗口
let Tlist_Use_Right_Window = 1           " 在右侧窗口中显示taglist窗口
map <F4> :TlistToggle<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""
"Ctags 5.9
"
"
set tags=tags;
set autochdir
   

"""""""""""""""""""""""""""""""""""""""""""""""""
"cscope 15.8b
"
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

























































