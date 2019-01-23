'''
head;tail
'''
-----------------------------------------------
#显示文件的后三行内容
tail -n -3 file		
tail -n 3 file
#显示从第三行到尾行的内容（不打印前两行）
tail -n +3 file	
#显示文件前三行	
head -n 3 file
head -n +3 file
#显示第一行到倒数第四行内容（不打印后三行）
head -n -3 file
-------------------------------------------------
'''
cut
'''
-b	#以字节为单位进行分割。
-b 1,3,5	#剪切每行的第1个，第3个，第5个字符
-b -5	#剪切每行的第1-5个字符
-b 3-	#剪切每行的第3个及其以后的字符
-nb		#如果中文的话-b会乱码，需要加-n
-c		#字符
-d		#分隔符
-f		#域概念
cat /etc/passwd | head|cut -d : -f 1
ifconfig eth0|grep "inet addr"|cut -d : -f 2|cut -d ' ' -f 1











