#!/bin/bash

echo "delete cscope.files cscope.out cscope.in.out cscope.po.out tags"

rm -rf cscope.files cscope.out cscope.in.out cscope.po.out tags

echo "create cscope.files"

## for kernel
find ./ -name "*.c" -o -name "*.cpp" >> cscope.files

echo "cscope add cscope.files"
cscope -Rbq -i cscope.files

ctags --langmap=c:+.h --languages=c,c++,java --links=yes --c-kinds=+px --c++-kinds=+px --fields=+iaKSz --extra=+q -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --if0=no -R -L cscope.files
