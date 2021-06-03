#!/usr/bin/env bash

rdir=`pwd`
serverHost=${1-fpga}

function  croot(){
	cd $rdir
}

#echo $serverHost

function cyimg(){
	cpath=`pwd`
	cdirName=`basename ${cpath}`
	echo "当前目录："${cdirName}
	if [[ $cdirName == *kernel* ]]
	then
		tftDir="/home/albter/Documents/zScript/devTftp"
		rm -rf ${tftDir}/*
		cp ${rdir}/arch/arm64/boot/Image ${tftDir}
		cp ${rdir}/arch/arm64/boot/dts/horizon/hobot-j3-fpga.dtb ${tftDir}
		#cp `find ${rdir}/drivers/ips -name "*.ko"` ~/Documents/net/devnfs/test/bin
	elif [[ $cdirName == *u-boot* ]]
	then
		if [[ ${serverHost} == "fpga" ]]
		then
			#sshpass -p 'hori123zon' scp -r u-boot.bin shlabpc01@10.106.32.14:~/xiaobo/workspace/image
			sshpass -p '888888' scp -r u-boot.bin xiaobo@10.106.32.14:~/Documents/image
		elif [[ ${serverHost} == "haps" ]]
		then
			sshpass -p 'cv01' scp -r u-boot.bin hzlabpc02@10.106.32.17:~/xiaobo/workspace/image
		fi
	elif [[ $cdirName == *testbench* ]]
	then
		echo "在这里添加需要copy的命令"
		rm -rf ../net/devnfs/*
		cp -r ${rdir}/install/* ../net/devnfs
	else
	  echo "请检查当前所在路径："${cpath}
	fi
}

function cpylog(){
	sshpass -p '888888' scp -r xiaobo@10.106.32.14:~/minicom.cap ~/Documents/net/logdir/log-$(date "+%Y%m%d_%H%M%S").txt
	sshpass -p '888888' ssh -t xiaobo@10.106.32.14 "rm -rf ~/minicom.cap; touch ~/minicom.cap" >/dev/null 2>&1
}
