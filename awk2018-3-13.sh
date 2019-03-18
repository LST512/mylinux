#awk用法2018-3-13，lst
#2019-3-15更新
#打印某个字符出现的行号
awk -F ';' '{for (f=1; f <= NF; f+=1) {if ($f ~ /Asinex/) {print NR,$f}}}' text.dat > asinex.dat
#更新时间 2018-11-30
#双引号与单引号有区别
# awk把前几行合并为一行
# 前3行，合并一行；行数除尽，\n换行符；否则去掉换行符;1就是{print $0}
awk '{if(NR%3!=0)ORS=" ";else ORS="\n"}{print $0}' test.txt
awk '{if(NR%3==0)ORS="\n";else ORS=" "}1' test.txt
# 前两行合并的另一种
sed -n '{N;s/\n/\t/p}' test.txt
awk '{if(NR%2!=0)ORS=" ";else ORS="\n"}{print $0}' test.txt
# igv处理 
# snapshotDirectory /home/lst/NGS/second_PAC_results/AN3661/igv_up
cat final.txt|awk 'BEGIN{RS="#"}{print $0}'|sed "s/\t//g" > igv_batch_up.txt
----------------------------------------------------------------------------
#NR>1去除第一行表头，begin为加了自定义表头。结果是求和;2019-1-4
'''
ID	C1	C2	C3
A	1	1	1
B	2	2	2
C	3	3	3
'''
cat README.txt|awk 'BEGIN{print "id","sum"}(NR>1){$2=$2+$3+$4;print $1,$2}'
#bioawk
bioawk -c fastx '{print $name,length($seq)}' input.fa
bioawk -c fastx '{print $name, gc($seq)}' input.fa
bioawk -c fastx '{print ">"$name;print revcomp($seq)}' input.fa
bioawk -c fastx 'length($seq)>100 {print ">"$name;print $seq}' input.fa
bioawk -c fastx '{print ">PREFIX"$name; $seq}' input.fa
bioawk -c fastx '{print ">"$name"|SUFFIX";$seq}' input.fa
bioawk -t -c fastx '{print $name,$seq}' input.fa
bioawk -c fastx '{print ">"$name; print $seq}' input.fastq
bioawk -t -c header '$age > "20" {print $0}' input.txt
--------------------------------------
cat 800long.txt|awk '{print $1,$3"\n"$4,$6}'#合并为竖排
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$2]}' 800seq_len.txt motif_site_len.txt
awk 'NR==FNR{a[$2]=$1}NR>FNR{print a[$1],$0}' f1 f2
-----------------------------------------
awk行号操作2018-6-13
-----------------------------------------
$2 > maxrate { maxrate = $2; maxemp = $1 }
END { print "highest hourly rate:", maxrate, "for", maxemp }
#每行间加一个空行
awk '1;{print ""}' file
#计算行数，类似wc-l
awk 'END{print NR}' file
#计算每一行的和
awk '{ s = 0; for (i = 1; i <= NF; i++) s = s+$i; print s }'   filname
#计算文件中所有字段的和:
awk '{ for (i = 1; i <= NF; i++) s = s+$i }; END { print s }'   filname
-------------------------------------------
#字符串连接
    { names = names $1 " "}
END { print names }
-------------------------------------------
#找唯一
awk '{print $0}' all_trans_id.txt no_blast_id.txt|sort|uniq -u > blast_id.txt
#将fasta序列合并成一行显示，必须是linux格式的，windows下会出错。可以用vim查看，显示dos的则为win格式。或者cat -A file也能看到
------------------------------------------------------
win文件转换为linux
----------------------------------
dos2unix filename
sed -i 's/^M//g' filename #注意：^M的输入方式是 Ctrl + v +M
cat filename |tr -d '\r' > newfile #window下的回车符多了‘\r’，那么当然通过删除‘\r’ 
------------------------------------------------------
awk '/^>/{print $0}' file #打印>开头的行
awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0" ":$0 }' file
awk '{ printf "%s",/^>/ ? $0" ":$0"\n" }' file
#统计某列的长度	
awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0" ":$0 }'  contig.fa |awk '{print $1"\t"length($3)}'
cat chinaFir_full_length_transcriptome_final_sequence.fa|awk '/^>/&&NR>1{print "";}{ printf "%s",/^>/ ? $0" ":$0 }'|awk '{print $1"\t"length($2)}' > transcript_length.tsv
--------------------------------------------
#加表头
cat AN3661.NAME|sed '/^$/d'|awk 'BEGIN{ORS="\t"}{print $2}'|xargs -i sed '1 i {}' AN3661_col0_PAC.tsv > AN3661_col0_PAC_res.tsv
#截取序列
#获得每行的长度
awk '{print NR ":" length($0);}' filename
#2018-9-7更新；NR打印行号；然后统计每行长度
#目的，做meme分析时，如果存在小于4的序列会报错，此代码就是为了去除短的序列以及标题
#思路；grep -vn '>' file 取得序列的行号与内容，默认是分号分割(不含标题)；awk打印行号与序列的长度；awk判断序列的长度是否大于等于4，然后输入行号（行号减一变为标题号）；sed -n '标题号,+1'p 来获得最终的序列文件。
##注意,win产生的格式fa和linux的不太一样,length计算长度可能错1，用前要测试下
# vim打开一小部分，如果是win的回显示[dos]
######
dos2unix filename
sed -i 's/^M//g' filename #注意：^M的输入方式是 Ctrl + v +M
cat filename |tr -d '\r' > newfile #window下的回车符多了‘\r’，那么当然通过删除‘\r’ 
######
#第一种
cat arab_tair10.t_gff10_org.3UTR.coord.fa|tr -d '\r'|grep -vn '>'|awk -F: '{print $1"\t"length($2)}'|awk '{if($2>3)print $1-1}'|cat|while read id;do sed -n "$id,+1"p arab_tair10.t_gff10_org.3UTR.coord.fa >> arab_tair10.t_gff10_org.3UTR.coord.4.fa;done
# 简化代码
cat arab_tair10.t_gff10_org.3UTR.coord.fa|tr -d '\r'|grep -vn '>'|awk -F: '{if(length($2)>3)print $1-1}'|cat|while read id;do sed -n "$id,+1"p arab_tair10.t_gff10_org.3UTR.coord.fa >> arab_tair10.t_gff10_org.3UTR.coord.4.fa;done

cat arab_tair10.t_gff10_ae120pm2k.3UTR.coord.fa|tr -d '\r'|grep -vn '>'|awk -F: '{print $1"\t"length($2)}'|awk '{if($2>3)print $1-1}'|cat|while read id;do sed -n "$id,+1"p arab_tair10.t_gff10_ae120pm2k.3UTR.coord.fa >> arab_tair10.t_gff10_ae120pm2k.3UTR.coord.4.fa;done
#第二种,标题与序列变成一行，然后awk统计长度，满足的打印出来，\n换行
cat arab_tair10.t_gff10_org.3UTR.coord.fa|tr -d '\r'|awk '{ printf "%s",/^>/ ? $0" ":$0"\n" }'|awk '{if(length($2)>3)print $1"\n"$2}' > arab_tair10.t_gff10_org.3UTR.coord.4.fa
cat arab_tair10.t_gff10_ae120pm2k.3UTR.coord.fa|tr -d '\r'|awk '{ printf "%s",/^>/ ? $0" ":$0"\n" }'|awk '{if(length($2)>3)print $1"\n"$2}' > arab_tair10.t_gff10_ae120pm2k.3UTR.coord.4.fa
--------------------------------------------
# 将某列值的加减乘除
cat 1.txt|awk '{$1=$1/2;$2=$2/2;$3=$3/2;print $0}'
#awk 删除第5列
cat file |awk ' { $5=null;print $0 }' 
awk '{$NF=null;$(NF-1)=null;print $0}'
#处理blast
cat final|awk 'BEGIN{FS="."}{print $2}'|awk '{$1=null;print $0}'|sed 's/$/.../g' > symbol
#打印偶数行
awk '{if(NR%2==0){print NR}}' file
awk '!NR%2' file
awk 'i++%2' file
#打印奇数行
awk '{if(NR%2==1){print NR}}' file
awk '(NR%2)' file
awk '++i%2' file
awk -F"," '{print $0;getline;}' file
-----------------------------------------
一般命令 FS,OFS;RS,ORS
-----------------------------------------
# 2018-10-18
#agriGO下载的文件，// AT5G13790 // AT1G30040\n// AT5G51810;将多行这样的文件合并为一列，去重，看功能
# RS行分隔符
#复杂
cat AN3661_AGRIGO_FILETR.TSV|tr "\n" ,|sed 's/,//g'|sed 's/\/\///g'|awk 'BEGIN{RS="  "}{print $0}'|sort|uniq
#简单
cat AN3661_AGRIGO_FILETR.TSV|awk 'BEGIN{RS="//"}{print $0}'|sed '/^$/d'|sort|uniq
#以特定分隔符处理，默认空格
awk -F ':' '{print $1}' filename	# ：加引号不是必须的
cat filename|awk -F '\t' '{print $1}' # \t加引号是必须的
awk 'BEGIN{FS=":"}{print $1,$2}' filename	#内置变量FS
#打印第一列
awk '{print $1}' filename
#打印倒数第二列
awk '{print $(NF-1)}'
#打印前二列
awk '{print $1,$2}' filename	#不加引号，逗号默认打印出来为空格分开
#打印完第一列，再打印第二列
awk '{print $1 $2}'
#以特定符号打印结果
cat filename|awk -F ':' '{print $1"\t"$7}'
#打印文件的行数
awk 'END{print NR}' filename #打印总行数
awk '{print NR}' filename	#打印出行数，如1,2,3
awk '{print NR}' file = awk '{print FNR}' file #单个文件两个一样,123
awk '{print FNR}' file1 file2 # 123,123 FNR不同的文件重新编号
#打印文件的列数
awk -F, 'END{print NF}' filename	#打印以逗号为分隔符，最大的列数。
awk -F, '{print NF}' filename	#打印以逗号为分隔符，显示每行的列数。
#多个分隔符号
awk -F"[,:%]" '{print $2}'	#以逗号，冒号，百分号为分隔符，不区分先后顺序，每个行独立。
awk 'BEGIN{FS="[,:%]"}{print $2}' #第二种
echo "a|b|c"|awk 'BEGIN{RS="|"}{print $0}' #输出结果为竖排的a b c
echo "a\nb\nc"|awk 'BEGIN{ORS="---"}{print $0}' #输出结果为a---b---c
cat "1,one:2,two:3,three"|awk 'BEGIN{RS=":";print "----begin----"}{print $0}' #多个用分号

#打印文本第一行
awk 'NR==1{print}' filename
#打印文本第二行第一列
sed -n "2,1p" filename | awk 'print $1'
#搜索功能
awk -F: '/root/{print $7}' /etc/passwd
#模式匹配
awk -F: '/root/{print $2,$3}' /etc/passwd
awk -F: '/root/{print "username\"s name:",$1}' /etc/passwd



------------------------------------------------
awk语法
-------------------------------------------------
'''
awk工作流程是这样的：先执行BEGING，然后读取文件，读入有/n换行符分割的一条记录，然后将记录按指定的域分隔符划分域，填充域，$0则表示所有域,$1表示第一个域,$n表示第n个域,随后开始执行模式所对应的动作action。接着开始读入第二条记录······直到所有的记录都读完，最后执行END操作。
'''
awk 'BEGIN{ commands } pattern{ commands } END{ commands }' file 
cat /etc/passwd |awk  -F ':'  'BEGIN {print "name,shell"}  {print $1","$7} END {print "haha"}'	# "name\tshell" 制表符隔开
#格式化输出
awk -F, 'BEGIN{print "----\nNAME\tPRICE\n----"}{print $2,"\t",$3;}END{print "---end---"}' file
#######
awk变量
#######
echo "abc,123\nasd,456\niop，789"|awk 'BEGIN{FS=",";total=0}{print $2"sum is:"$2;total=total+$2}END{print "---\ntotal sum="total}' #可以写成awk脚本
#'''
#BEGIN{
#  FS=",";
#  total=0}
#{
#print $2 "'s star is:" $2;
#total=total+$2
#}END{
#print "---\ntotal star=" total;
#}
#'''
echo "5,3"|awk '{print--$1}' #第一个数字减1，即4
echo "5,3"|awk '{$1--;print $1}'
echo "5,3"|awk '{print++$1}' #第一个数字加1，即6
echo "5,3"|awk '{$1++;print $1}'
------------------------
'''
BEGIN{
 FS=",";
 OFS=",";
 num1=num2=num3=num4=num5=9;
 num1 +=5;print num1;
 num2 -=5;print num2;
 num3 *=5;print num3;
 num4 /=5;print num4;
 num5 %=5;print num5;
}
'''
-----------
##########
比较操作
#########
#显示大于等于30的行
awk -F, '$1>=30' file
awk -F, '$1==103{print $2}' file
awk -F, '$1>30||$1<70 {print $1}' files	#或者||；和&&
-----------------------
###########
正则
###########
# ~表示匹配，!~表示不匹配
awk -F; '$1~"root"' /etc/passwd	#打印匹配root的行，字符串要加引号
awk -F; '$1!~"root"' /etc/passwd	#打印不匹配root的行
awk -F: '$NF ~ "/usr/sbin/nologin/"{ n++ };END{print n}' /etc/passwd	#以冒号为分隔符，NF是分隔项数据，$NF表示最后一个分隔符,即找出最后一列为/bin/sh的，统计次数。
###########
IF 语法
if (conditional-expression)
    action
#or
if (conditional-expression)
{
action1;
action2; }
###########
awk -F, '{if($2>200)print$0}' file	#以逗号为分隔符，打印file中第二列大于200的行
awk -F: '{if($1~"root")print $0}' /etc/passwd	#以逗号为分隔符，打印文件中第一列含有root的行。
awk -F, '{if($2>200)n++};END{print n}' file	#以逗号为分隔符，打印file中第二列大于200的行总数
awk -F, '{if($2>200)n++};{if($2>200)print $0};END{print n}' file	#以逗号为分隔符，打印file中第二列大于200的行，总后打印总行数
awk -F, 'BEGIN{print "匹配的行为："}{if($2>200)n++};{if($2>200)print $0};END{print "总行数为""\n" n}' test3
awk -F, '{if($2>200)n++};{if($2>200)print "匹配的行为：" $0};END{print "总行数为"n}' test3
------------------------------------------------------
-------------------------------------------------------
###################
if (conditional-expression)
    action1
else
    action2
# or
conditional-expression ? action1 : action2 ;
###################
awk '{if($1>300)print"大于300";else if($1==456) print "等于300"; else print "小于300"}' file	#语法分号分开。
awk 'ORS=NR%2?",":"\n"'	# 前两行合并为一行
awk '{if(NR%2!=0)ORS=" ";else ORS="\n"}1' file	# 前两行合并为一行
------------------------------------------------------
------------------------------------------------------
#############
while语法
while(condition)
    actions
###########
BEGIN{
FS=","
}
{
	i=2;sum=0;
	while(i<=NF){
		sum=sum+$i;
		i++;
}
print "num",$1,":",sum,"string";
}
------------------------------------------------------
####################
do while 语法
do
action
while(condition)
##################
{
i=2;sum=0;
do
{
	sum=sum+$i;
	i++;
}while(i<=NF)
print "num",$1,":",sum,"string";
}
--------------------
#############
for语法
#for(initialization;condition;increment/decrement)
#actions
#############
echo "1 2 3 4"|awk '{for(i=1;i<=NF;i++)sum=sum+$i}END{print sum}'	#每列数求和，10
echo "1 2 3 4"|awk 'BEGIN{sum=10}{for(i=1;i<=NF;i++)sum=sum+$i}END{print sum}' #初始sum为10，结果为20
############
'''
{
    sum=0;
    for (i=2; i <= NF; i++)
        sum = sum + $i;
   print "num",$1,":",sum,"string";
}
'''
############
---------------------------------------------------
############
BREAK,CONTINUE,EXIT
############
awk 'BEGIN{
quote> x=1;
quote> while(1)
quote> {
quote> print"abc";
quote> if(x==10)
quote> break;
quote> x++;
quote> }}'
打印十行abc
#############
awk 'BEGIN{
x=1;
while(x<=10)
{
if(x==5){
x++;
continue;
}
print "Value of x",x;x++;
}
}'
x从1到10, 如果x等于5 直接累加x而不打印
#########
awk 'BEGIN{
x=1;
while(x<=10)
{
if(x==5){
exit;}
print "Value of x",x;x++;
}
}'
x从1到10,当x等于5的时候程序直接退出
#############
关联数组
#############
awk 'BEGIN {item[101]="Github"; print item["101"]}'	#Github
awk 'BEGIN {item[101]="a"; if ( 101 in item ) print "存在101"}'	#存在101
##########
BEGIN{
	item["1,1"]="abc";
	item["2,2"]="123";
	item["3,3"]="def";
	item["4,4"]="456";
	delete item["2,2"]
	for(i in item)
		print i,item[i]
}
#多维数组, delete可以删除元素
######

