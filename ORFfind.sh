#NCBI的orffinder
ORFfinder -in transport.fasta -s 0 -g 1 -ml 75 -out output
#OrfPredictor.pl
#http://bioinformatics.ysu.edu/tools/OrfPredictor.html
#参数如下，BLASTX为新建的空白文件，0表示没有BLASTX,both表示双链,1e-5为取值 out输出结果
#（BLASTX 0 both三个参数必须写但是没用）
perl OrfPredictor.pl transport.fasta BLASTX 0 both 1e-5 out
--------------------------
之前网页版的ORFfinder除运行速度较慢外，还存在两方面的缺陷：
一是上传查找ORF只能开一个网页，每次弄一个CDS，blast完后还得再退回到上传序列那个页面
二是密码子Genetic_code不完整，如第22套密码子并没有提供
今天，打开ORFfinder惊喜地发现有新版本问世。

从ftp://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/ORFfinder/linux-i64/ 下载Linux版的ORFfinder
解压后，
sudo chmod 777 ORFfinder  #获取执行权限
./ORFfinder -h
#当场就想运行了，哈哈，也可以 cp ORFfinder ～/bin（或者其它地方，在路径上即可，这样就可以在任何地方直接运行了）

具体参数打印出来，其中有个dryrun的选项，顾名思义可翻译为空载，先测试一下。什么都没有显示就表示一切配置OK
./ORFfinder -dryrun

输入文件可以是两种，一种是直接的fasta文件，另一种是Accession号或gi号，如果不小心两个都给了，软件会以给出的fasta文件为主
-b 接一个整数，指定序列上从哪个位点开始翻译（begin）
-e 接一个整数，指定翻译到哪一个位点结束（end）
-c 接t/f（或true/false），指明序列是否是环形，默认是false

-g 接一个整数，指定是哪一套密码子（可选0-25，0表示起始位点为ATG的ORF，默认是0），想了解有关Genetic code的内容请访问http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi
-ml 接一个整数指定ORF的最小长度是多少个nt，默认值75
-n 接t/f（或true/false）指明是否忽略ORF里边的ORF(完全被包含的ORF)，默认为false

-out 接输出的文件名
-outfmt 接一个整数，如下（默认是0）：
       0 = list of ORFs in FASTA format,
       1 = CDS in FASTA format,
       2 = Text ASN.1,
       3 = Feature table

因此可以使用以下代码：
./ORFfinder -in target.fasta -g 22 -ml 100 -out orf.out
# 运行完直接生成氨基酸序列，真的是太方便了，必须点赞！！
-
--------------------------
