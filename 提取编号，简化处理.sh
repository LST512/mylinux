'''
lst 2018-3-17
-----------------------------------------------
将测序的文件名提取出来,省去后面复制粘贴文件名
------------------------------------------------
'''
#step1 列出所有的目标文件名，重定向到该文本里面，以fastq.gz格式为例
ls *.fastq.gz > id.txt
#step2 根据需要处理的参数，在首尾添加内容，以hisat2为例
#hisat2 -p 5 -x $reference -U bakPe1200dnR1-2_L1_7923.R1.clean.fastq.gz -S $data_dir/Pe1200dnR1.sam
cat id.txt|sed 's/^/hisat2 -p 5 -x $reference -U /g'|sed 's/$/ -S $data_dir/g' > hisat2_1.txt
#切分bakPe1200dnR1-2_L1_7923.R1.clean.fastq.gz，最终得到bakPe1200dnR1.sam
cat id.txt|awk -F '-' '{print $1}'|sed 's/$/.sam/g' > hisat2_2.txt
#合并hisat2_1与jisat2_2初步得到目标文件
paste hisat2_1.txt hisat2_2.txt > hisat2.txt
#替换多余内容
sed 's/Pe\tPe/Pe/g' hisat2.txt > finall.txt


