scp [参数] [源文件] [目标文件]
scp -P 22086 P_heterocycla.fa lyma@59.79.232.61:/home/lyma/P_heterocycla/
scp -P 22 Pe1200dnR1Aligned.sortedByCoord.out.bam polya@59.79.232.46:/home/polya/Desktop
#如何后台运行
scp -P 22 *.bam polya@59.79.232.46:/home/polya/bamboo/bamboo_index/bam_files
Ctrl + Z
jobs查看
bg %1（看jobs决定数字）
disown -h %1 将这个作业忽略HUP信号
