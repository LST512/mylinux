#!/bin/bash
'''
PAS-Seq数据分析流程,在基于debian的deepin系统测试。
macOS理论也行，请自行测试。这是整理的流程，加了
一些注释。具体的参数根据情况调整。
包含dapar与APAtrap的处理流程。
2018-3整理
'''
#################
1.依赖包
#################
sra-toolkit(提取fastq序列)
fastqc;flexbar(质控与去除接头等)
bowtie/bowtie2/tophat2/hisat2/star;建立index,用于mapping
samtools;将mapping的sam文件转为bam文件，并进行sort
bedtools；生成bedgraph文件，用于后期dapars的处理
dapars文件；分析APA
'''
除dapars外，其他大部分都可以在终端安装，或者自行搜索安装。
sudo apt install xxx
安装后可以用man xxx/ xxx -h/ xxx --help等查看用法
'''
-----------------------------------------------------
#################
2.基因文件
#################
2.1 基因组数据注释文件bed格式：tair10_gene.bed
2.2 gene的symbol文件：tair10_gene_symbol
2.3 genome数据,用于后期建立index：tair10.fa
2.4 index文件：可以由bowtie/bowtie2/tophat2/hisat2/star生成
2.5 注释的UTR文件,由dapars生成：tair10_annotated_3UTR
2.6 chrome_size文件
'''
这些文件有提供，或者自行下载，生成需要的。
'''
------------------------------------------------------
#################
3.前期流程
#################

#3.1 下载sra数据，自己的测序数据一般可直接从3.4开始
#可以从NCBI里面的SRA搜索关键词来获取数据，参考http://blog.sina.com.cn/s/blog_7f1542270102wdk4.html
nohup wget -i sra_data.txt & #(nohup...& 用于后台挂起来执行)

#3.2 提取fastq序列，可加--gzip命令,压缩数据
fastq-dump --split-files SRR2000036.sra  #双端测序
fastq-dump SRR2000036.sra #单端测序

#3.3 质量检测与接头去除
#fastqc to check quality and over-represent sequences, no overrepresented sequences hit, problely no adaptor contamination
fastqc xxx.fastq  #生成两个文件，fastqc可以命令端，也可以图形端运行
#use flexbar to trim adaptor contamination
flexbar -r SRR966478.fastq -a /home/polya/adaptor_contamination_list.fa -n 8
#if contain N in reads, trim with -u option, w/ or w/o -a
flexbar -r SRR966478.fastq -n 0
'''
大部分情况下下载的序列或公司返回的序列已经去除接头或者低质量序列
'''
#3.4 生成的文件与基因组mapping，推荐用bowtie2/hisat2/star. bowtie2 -h或者hisat2 -h 查看用法
#建立index方法 bowtie2-build tair10.fa tair10
bowtie2 -L 25 -N 0 -i S,1,1.15 --no-unal -x tair10 -q -U /home/polya/xxx.fastq -S /home/polya/xxx.sam #单端
bowtie2 -L 25 -N 0 -i S,1,1.15 --no-unal -x tair10 -q -1 /home/polya/xxx_1.fastq -2/home/polya/xxx_2.fastq -S /home/polya/xxx.sam #双端
'''
fastq.gz的格式可直接用于处理
'''
#3.5 samtools处理sam文件生成bam文件，并进行sort
#samtools sort [-l level] [-m maxMem] [-o out.bam] [-O format] [-n] [-T tmpprefix] [-@ threads] [in.sam|in.bam|in.cram]
samtools view -bS xxx.sam > xxx.bam
samtools sort -o xxx.bam_sorted -T sorted xxx.bam
#3.6 bedtools处理bam_sorted文件
genomeCoverageBed -bg -ibam xxx.bam_sorted -g /home/polya/tair10.chrom.sizes -split > xxx.bedgraph
#3.7 如果生成的bedgraph文件前端无Chr前戳，后续dapars分析会报错，这里替换拟南芥的chloroplast为c;mitochondria为m.表头加Chr。
#按照顺序执行以下命令，如果不想在源文件上修改可以重定向。执行 sed 's/chloroplast/c/g' xxx.bedgraph > xxx_Chr.bedgraph（去掉-i）。
sed -i 's/chloroplast/c/g' xxx.bedgraph
sed -i 's/mitochondria/m/g' xxx.bedgraph
sed -i 's/^/Chr&/g' xxx.bedgraph

#################
Dapars处理
#################
#extract annotated polyA site,do this step at the first time only.
python DaPars_Extract_Anno.py -b /home/polya/TAIR10.genes.bed -s tair10_gene_symbol -o tair10_Annotated_3UTR
#extract and quantify APA in samples,set the configure.txt first.
python DaPars_main_arabidopsis.py /home/polya/configure.txt
最后得到的文件可用excel打开。

#################
APAtrap流程
#################
----------------------
依赖包，自行查阅安装
----------------------
For running APAtrap from source codes, you should make sure the 'Perl environment 'and the following 'Perl dependency packages' required by APAtrap are installed.
[1] [Getopt::Long](http://search.cpan.org/~jv/Getopt-Long-2.50/lib/Getopt/Long.pm)
[2] [Smart::Comments](http://search.cpan.org/~neilb/Smart-Comments-1.06/lib/Smart/Comments.pm)
[3] [List::Util](http://search.cpan.org/~pevans/Scalar-List-Utils-1.49/lib/List/Util.pm)
[4] [experimental](http://search.cpan.org/~leont/experimental-0.019/lib/experimental.pm)
[5] [List::MoreUtils](http://search.cpan.org/~rehsack/List-MoreUtils-0.428/lib/List/MoreUtils.pm)
[6] [Math::NumberCruncher](http://search.cpan.org/~sifukurt/Math-NumberCruncher-5.00/NumberCruncher.pod)
------------------------------------------------------------------------------------------------------------
-----------------------
APAtrap安装步骤
-----------------------
[1].'https://sourceforge.net/projects/apatrap/files/ '；Download and unzip our package - 'APAtrap_Linux.zip' (or APAtrap_Windows.zip, APAtrap_MacOS.zip)
After you download and unzip our APAtrap package, you will see a folder named APAtrap, where 2 standalone executables ('identifyDistal3UTR' and 'predictAPA') compressed from Perl programs
and 1 R package ('deAPA_1.0.tar.gz') are located.
[2]. Install R package 'deAPA_1.0.tar.gz'
You shoule make sure the 'R environment' is installed. After opening the R, change the Rs Working Path to the path where 'deAPA_1.0.tar.gz' is located (e.g., './APAtrap'). Type the following command in the Command Window of R:
> install.packages("deAPA_1.0.tar.gz",repos = NULL, type = "source") 

----------------------
APAtrap流程
----------------------

#(1) run identifyDistal3UTR to refine annotated 3UTRs and identify novel 3UTRs or 3UTR extensions.
#identifyDistal3UTR -h  查看用法
#For genome having long 3'UTR
identifyDistal3UTR -i Sample1.bedgraph Sample2.bedgraph -m hg19.genemodel.bed -o novel.utr.bed 
#For genome having short 3'UTR
identifyDistal3UTR -i Sample1.bedgraph Sample2.bedgraph -m rice.genemodel.bed -o novel.utr.bed -w 50 -e 5000  
#(2) run predictAPA to infer all potential APA sites and estimate their corresponding usages
#predictAPA -h  查看用法
#For genome having long 3'UTR
predictAPA -i Sample1.bedgraph Sample2.bedgraph -g 2 -n 1 1 -u hg19.utr.bed -o output.txt 
#For genome having short 3'UTR
predictAPA -i Sample1.bedgraph Sample2.bedgraph -g 2 -n 1 1 -u rice.utr.bed -o output.txt -a 50 
#(3) run R function deAPA to detect genes having significant changes in APA site usage between conditions
deAPA(input_file, output_file, group1, group2, least_qualified_num_in_group1, least_qualified_num_in_group2, coverage_cutoff)
----------------------
具体参照例子
----------------------

#1st step: type the following command in the Commond Promt of Linux or Windows
$ ./identifyDistal3UTR -i Sample1.bedgraph Sample2.bedgraph -m hg19.genemodel.bed -o test.utr.bed
#2nd step: type the following command in the Commond Promt of Linux or Windows,
$ ./predictAPA -i Sample1.bedgraph Sample2.bedgraph -g 2 -n 1 1 -u test.utr.bed -o test.APA.txt
#3rd step: type the following command in the R Commond Promt
 > library(deAPA)
 > deAPA("test.APA.txt", "test.APA.stat.txt", 1, 2, 1, 1, 20)
产生的test.APA.stat.txt为最终结果，可用excel打开。

