#/bin/bash
awk '{print $0}' file1 file2|sort|uniq -u	# 合并-->排序-->显示唯一
comm -3 ----nocheck-order file1 file2		#-1不输出file1特有行，-2不输出file2特有行，-3打印file1有file2没有的行
comm -12 file1 file2 #打印共有行
#grep -v -f test2 test1	#test2里面的内容取匹配test1，结果取反就得到非共同数据
