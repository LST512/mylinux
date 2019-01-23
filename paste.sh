#paste命令
'''paste可以简单的理解为把两个文件的内容按列合并
将两个文件中的内容按照文件顺序从左往右排起来'''
#基本命令
paste -d"\t" salt_id tair_id func NF-1 NF > final.txt
paste file1 file2 > result
#拼接时使用指定符号隔开各个文件的内容，双引号和单引号甚至不用引号的结果一样，而且只能指定一个字符
paste -d':' file1 file2
#删除所有换行
paste file1 -s
paste file1 file2 -s
aste file1 -s -d:
