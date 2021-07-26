#!/usr/bin/env bash

rdir=`pwd`
serverHost=${1-fpga}

function  croot(){
	cd $rdir
}

#echo $serverHost

function cyimg(){
	flag=${1:-0}
	#echo $flag
	cpath=`pwd`
	cdirName=`basename ${cpath}`
	tftDir="/home/albter/devnet/tftp"
	nfsDir="/home/albter/devnet/nfs"
	logDir="/home/albter/net/logdir"
	echo "当前目录："${cdirName}
	if [[ $cdirName == *kernel* ]]
	then
		if [[ $flag == 1 ]]
		then
			rm -rf ${tftDir}/*
		fi
		if [[ $cdirName == fpga.* ]]
		then
			cp ${rdir}/arch/arm64/boot/Image ${tftDir}/Image.fpga
		else
			cp ${rdir}/arch/arm64/boot/Image ${tftDir}
		fi
		cp ${rdir}/arch/arm64/boot/dts/horizon/hobot-j5-fpga-camera.dtb ${tftDir}
		cp ${rdir}/arch/arm64/boot/dts/horizon/hobot-j3-fpga.dtb ${tftDir}
		#cp `find ${rdir}/drivers/ips -name "*.ko"` ${nfsDir}/test/bin
	elif [[ $cdirName == *u-boot* ]]
	then
		if [[ ${serverHost} == "fpga" ]]
		then
			sshpass -p '888888' ssh -t xiaobo@10.106.32.14 "rm -rf ~/Documents/image/u-boot.bin" >/dev/null 2>&1
			sshpass -p '888888' scp -r u-boot.bin xiaobo@10.106.32.14:~/Documents/image
		elif [[ ${serverHost} == "haps" ]]
		then
			sshpass -p 'cv01' scp -r u-boot.bin hzlabpc02@10.106.32.17:~/xiaobo/workspace/image
		fi
	elif [[ $cdirName == *testbench* ]]
	then
		echo "在这里添加需要copy的命令"
		rm -rf ${nfsDir}/*
		cp -r ${rdir}/install/* ${nfsDir}
	else
	  echo "请检查当前所在路径："${cpath}
	fi
}

function cpylog(){
	sshpass -p '888888' scp -r xiaobo@10.106.32.14:~/minicom.cap ${logDir}/log-$(date "+%Y%m%d_%H%M%S").txt
	sshpass -p '888888' ssh -t xiaobo@10.106.32.14 "rm -rf ~/minicom.cap; touch ~/minicom.cap" >/dev/null 2>&1
}
