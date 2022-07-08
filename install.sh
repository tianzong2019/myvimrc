#!/bin/bash

dst=~/.vim
rm -rf ${dst}*

scdir=$(cd $(dirname $0);pwd)
tempdir=${scdir}/.temp

rm -rf ${tempdir}
mkdir -p ${tempdir}/vim
cp ${scdir}/toolset/basic.txt ${tempdir}/vimrc

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
	neocomplete.vim-master
	nerdcommenter-2.5.2
	nerdtree-6.10.10
	taglist_46
#	vim-autoformat-master
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

rm -rf ${tempdir}


