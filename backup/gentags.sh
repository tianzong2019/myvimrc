#!/bin/bash

echo "delete cscope.files cscope.out cscope.in.out cscope.po.out tags"

rm -rf cscope.files cscope.out cscope.in.out cscope.po.out tags

echo "create cscope.files"

cpath=`pwd`
cdirName=`basename ${cpath}`
echo "当前目录："${cdirName}


if [[ $cdirName == *kernel* ]]
then
	## for kernel
	find ./drivers/ips/j5 -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
elif [[ $cdirName == *u-boot* ]]
then
	echo "请添加需要检索的code path"
elif [[ $cdirName == *testbench* ]]
then
	## for testbench
	find ./hobot_module -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
	#
	find ./hobot_app/test/inc -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
	find ./hobot_app/test/lib -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
	#find ./hobot_app/test/src/scenario -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
	find ./hobot_app/test/src/j3_vio -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
	find ./hobot_app/test/src/isp -name "*.c" -o -name "*.cpp" -o -name "*.h" >> cscope.files
else
  echo "请检查当前所在路径："${cpath}
fi




echo "cscope add cscope.files"
cscope -Rbq -i cscope.files

ctags --langmap=c:+.h --languages=c,c++,java --links=yes --c-kinds=+px --c++-kinds=+px --fields=+iaKSz --extra=+q -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --if0=no -R -L cscope.files
