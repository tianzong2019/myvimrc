#!/bin/bash

dst=~/.vim
rm -rf ${dst}*

scdir=$(cd $(dirname $0);pwd)
tempdir=${scdir}/.temp

rm -rf ${tempdir}
mkdir -p ${tempdir}/vim
cp -rf ${scdir}/toolset/basic.txt ${tempdir}/vimrc
cp -rf ${scdir}/toolset/cus.clang-format ${HOME}/.config/cus.clang-format

#### 插件列表 ###########################################################
#  bufexplorer-7.4.21
#  DoxygenToolkit.vim-master
#  global-6.6.7
#  LeaderF-1.23
#  neocomplete.vim-master
#  nerdcommenter-2.5.2
#  nerdtree-6.10.10
#  taglist_46
#  vim-autoformat-master
#  vim-gutentags-master
#  vim-ingo-library-1.042
#  vim-mark-3.1.1
#
toolarr=(
	bufexplorer-7.4.21
	DoxygenToolkit.vim-master
	global-6.6.7
	LeaderF-1.23
#	neocomplete.vim-master
	nerdcommenter-2.5.2
	nerdtree-6.10.10
	taglist_46
	vim-autoformat-master
	lightline.vim-master
	vim-gutentags-master
	vim-ingo-library-1.042
	vim-mark-3.1.1
)

for tool in ${toolarr[@]};do
	echo "加载 "$tool
	
	# 解压插件包
	unzip -x -o -q ${scdir}/toolset/${tool} -d ${tempdir}/${tool}
	if [[ ! "$?" -eq "0" ]];then
		echo -e "执行失败"
	fi
	
	# 合并插件
	plugdir=`find ${tempdir}/${tool} -type d -name "plugin" -o -name "autoload" | sed -n "1p"`
	ppdir=$(dirname "${plugdir}")
	cp -rfp ${ppdir}/* ${tempdir}/vim
	
	# 写配置文件到vimrc
	echo '"'`printf '%0.s"' $(seq 1 50)` >> ${tempdir}/vimrc
	echo '" '${tool} >> ${tempdir}/vimrc
	echo '"'         >> ${tempdir}/vimrc
	cat  ${scdir}/toolset/${tool}.txt | while read line
	do
		echo $line >> ${tempdir}/vimrc
	done
	printf '%0.s\n' $(seq 1 4) >> ${tempdir}/vimrc
	
	# 删除临时文件
	rm -rf ${tempdir}/${tool}
done

chmod 777 ${tempdir}/vim/plat/unix/*.sh

# 完整的vim 和 vimrc copy 到${HOME}
mv ${tempdir}/vim ${HOME}/.vim
mv ${tempdir}/vimrc ${HOME}/.vimrc

# dejaVu='DejaVu_Sans_Mono_for_Powerline_Nerd_Font'
# unzip -x -o -q ${scdir}/toolset/${dejaVu}.zip -d ${tempdir}
# mkdir -p ~/.fonts
# cp -f ${tempdir}/${dejaVu}/*.ttf ~/.fonts
# fc-cache -vf              #刷新系统字体缓存

rm -rf ${tempdir}


# dst=global-6.6.8
# wget https://ftp.gnu.org/pub/gnu/global/${dst}.tar.gz
# tar -zxf ${dst}.tar.gz
# cd ${dst}
# ./configure
# make -j4 
# sudo make install 
# cd ../
# rm -rf ${dst}*


# alias cyimg='cyimgfunc(){ \
#     dstdir="/home/xxx/tftp" ;   \
#     srcdir=`date +%Y%m%d_%H%M%S.%N`"_out_put" ; \
#     rm -rf ${dstdir}/"out_put"; \
#     mkdir -p ${dstdir}/"out_put"; \
#     if test -d "out_put" ; \
#     then \
#             cp -rf "out_put" ${dstdir}/${srcdir} ;  \
#     else \
#             echo "current No out_put" ; \
#             return 0 ;                    \
#     fi; \
#     for itm in `ls ${dstdir}/${srcdir}` ;do \
#             ln -fn ${dstdir}/${srcdir}/$itm ${dstdir}/out_put/$itm; \
#     done; \
#     ln -fs ${dstdir}/${srcdir} ${dstdir}/out_put; \
# };cyimgfunc'
#  
#  
#  
# alias crootinit='croot(){ \
#     cd ${rootdir};   \
# };rootdir=`pwd`'
#  
#  
# alias cpvs='cp -rf ~/0617-vscode/ .vscode'
#  
# alias bdtb='git clean -fdx . ;cpvs ;./mk_testbench.sh ;compiledb -p compile_log.txt'
#  
# alias bdker='git clean -fdx . ;cpvs ;./mk_kernel.sh -m; ./mk_kernel.sh -j; cyimg ;./.vscode/generate_compdb.py'


# ubuntu 18.04 安装clang-format-13、14、15、16
# 首先需要删除已有版本: sudo apt remove --purge clang-format*
# 步骤一: 运行 wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - 获取key.
# 步骤二: 在 /etc/apt/sources.list中添加下列文本
# ubuntu18.04
#	deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
#	deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
#	# Needs 'sudo add-apt-repository ppa:ubuntu-toolchain-r/test' for libstdc++ with C++20 support
#	# 12
#	deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
#	deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
#	# 13
#	deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main
#	deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main
#	# 14
#	deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-14 main
#	deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-14 main
#	# 15
#	deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-15 main
#	deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-15 main
# 步骤三: sudo apt update
# 步骤四: apt search clang-format 检查所有可用版本
# 步骤五: 使用sudo apt install clang-format-14 安装,
# 步骤六：使用update-alternatives管理clang-format版本
# 添加， sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-14 1
# 删除，sudo update-alternatives --remove clang-format /usr/bin/clang-forma
#    or sudo update-alternatives --remove-all clang-format


# 用法：update-alternatives [<选项> ...] <命令>
# 
# 命令：
#   --install <链接> <名称> <路径> <优先级>
#     [--slave <链接> <名称> <路径>] ...
#                            在系统中加入一组候选项。
#   --remove <名称> <路径>   从 <名称> 替换组中去除 <路径> 项。
#   --remove-all <名称>      从替换系统中删除 <名称> 替换组。
#   --auto <名称>            将 <名称> 的主链接切换到自动模式。
#   --display <名称>         显示关于 <名称> 替换组的信息。
#   --query <名称>           机器可读版的 --display <名称>.
#   --list <名称>            列出 <名称> 替换组中所有的可用候选项。
#   --get-selections         列出主要候选项名称以及它们的状态。
#   --set-selections         从标准输入中读入候选项的状态。
#   --config <名称>          列出 <名称> 替换组中的可选项，并就使用其中
#                            哪一个，征询用户的意见。
#   --set <名称> <路径>      将 <路径> 设置为 <名称> 的候选项。
#   --all                    对所有可选项一一调用 --config 命令。
