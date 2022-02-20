# 说明

环境：
- ubuntu server 20.04
- vim 8.1
- python 3.6
- nodejs 14.19.0

插件：
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
