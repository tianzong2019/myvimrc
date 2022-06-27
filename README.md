# 说明

简单安装
- git clone https://github.com/tianzong2019/myvimrc.git
- cd myvimrc
- ./install.sh

插件
- bufexplorer-7.4.21
- DoxygenToolkit.vim-master
- global-6.6.7
- LeaderF-1.23
- neocomplete.vim-master
- nerdcommenter-2.5.2
- nerdtree-6.10.10
- taglist_46
- vim-autoformat-master
- vim-gutentags-master
- vim-ingo-library-1.042
- vim-mark-3.1.1



<hr/>
环境：
- ubuntu server 20.04
- vim 8.1
- python 3.6
- nodejs 14.19.0

插件(abandoned)：
- cscope
  - autoload_cscope.vim
- ctags
  - vim-gutentags
- taglist
- mark.vim
- bufexploer
- quickfix
- insearch
- NerdCommenter
- nerdtree
- lightline
- leaderf
- coc.nvim
  - curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  - sudo apt-get install -y nodejs
  - yarn install
  - yarn build
  - 执行命令:CocInstall coc-clangd
  - sudo apt install clangd 安装C/C++ Language Server
  - 执行:CocInstall coc-snippets 安装代码片段
  - 代码段集合，honza/vim-snippets
