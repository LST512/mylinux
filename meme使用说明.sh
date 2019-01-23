# meme使用说明
# lst
# date 2018-4-24
'''
step1 依赖安装
'''
# 下载、解压
http://meme-suite.org/doc/download.html/
tar zxf meme_4.12.0.tar.gz
cd meme_4.12.0
#### 依赖 perl python zlib Assorted common utilities
# perl,查看缺失的依赖，然后安装. 例如:sudo cpan Math::CDF.如果速度慢可以修改cpan镜像源。
#修改~/.cpan/CPAN/MyConfig.pm;'urllist' => [q[ftp://mirrors.ustc.edu.cn/CPAN/]]
cd scripts
perl dependencies.pl
sudo apt install libexpat1-dev
#python
#zlib
sudo apt install zlib1g-dev
#Assorted common utilities
sudo apt install autoconf
sudo apt install automake
sudo apt install libtool
sudo apt install default-jdk
#libxml2 libxsl的安装
sudo apt install libxml2-dev
sudo apt install libxslt1-dev

'''
step2 安装meme
'''
#步骤
cd meme_4.12.0
./configure --prefix=$HOME/opt/meme --with-url=http://meme-suite.org --enable-build-libxml2 --enable-build-libxslt
make
make test	#会出现DMERE报错，貌似不影响
make install

'''
step3 运行
'''
meme unigene_switch.c0Xc350.FU.long.genepac.fasta -dna -oc . -V -time 86400 -maxsize 60000 -mod zoops -nmotifs 100 -minw 4 -maxw 50 -revcomp

meme unigene_switch.c0Xc800.FU.long.genepac.fasta -dna -oc . -V -maxsize 600000 -bfile all_markov0 -mod zoops -nmotifs 50 -minw 5 -maxw 5 -revcomp 

meme unigene_switch.c0Xc800.FU.long.genepac.fasta -dna -oc . -V -maxsize 60000 -mod zoops -nmotifs 50 -minw 6 -maxw 6 -revcomp 
---------
nohup meme unigene_switch.c0Xc800.FU.long.genepac.fasta -dna -oc ./800long_6 -V -maxsize 600000 -bfile all_markov0 -mod zoops -nmotifs 100 -minw 6 -maxw 6 -revcomp &
----------
nohup meme transport_800long_seq.fasta -dna -oc ./800long_trans_strand+ -V -maxsize 60000 -bfile all_markov0 -mod zoops -nmotifs 50 -minw 4 -maxw 50 &
------
# rna
nohup meme 800_transport_RNA.FASTA -rna -oc ./800_transport_rna -V -maxsize 60000 -bfile all_markov0 -mod zoops -nmotifs 50 -minw 4 -maxw 50 & 
---------
nohup meme unigene_switch.c0Xc800.FU.short.genestopTOprox.fasta -dna -oc ./stop2pro -V -maxsize 600000 -bfile all_markov0 -mod zoops -nmotifs 50 -minw 4 -maxw 50 &
'''
生成的xml文件可以用tbtools转换成无损图片，
或者mast -oc . -nostatus -bfile markov3 meme.xml transport_800long_seq.fasta
'''
#生成background文件
fasta-get-markov [options] [sequence file] [background file]
fasta-get-markov -m 3 transport_800long_seq.fasta markov3
# meme -h
# meme sequence-file -dna|rna|protein|alph
#   [-o <output dir>]	name of directory for output files will not replace existing directory
#   [-oc <output dir>]	name of directory for output files will replace existing directory
#   [-text]			output in text format (default is HTML)
#	[-dna]			sequences use DNA alphabet
#	[-rna]			sequences use RNA alphabet
#	[-protein]		sequences use protein alphabet
#	[-alph <alph file>]	sequences use custom alphabet
#	[-mod oops|zoops|anr]	distribution of motifs
#	[-nmotifs <nmotifs>]	maximum number of motifs to find
#	[-evt <ev>]		stop if motif E-value greater than <evt>
#	[-nsites <sites>]	number of sites for each motif
#	[-minsites <minsites>]	minimum number of sites for each motif
#	[-maxsites <maxsites>]	maximum number of sites for each motif
#	[-wnsites <wnsites>]	weight on expected number of sites
#	[-w <w>]		motif width
#	[-minw <minw>]		minimum motif width
#	[-maxw <maxw>]		maximum motif width
#	[-nomatrim]		do not adjust motif width using multiple alignment
#	[-wg <wg>]		gap opening cost for multiple alignments
#	[-ws <ws>]		gap extension cost for multiple alignments
#	[-noendgaps]		do not count end gaps in multiple alignments
##	[-bfile <bfile>]	name of background Markov model file
#	[-revcomp]		allow sites on + or - DNA strands
#	[-pal]			force palindromes (requires -dna)
#	[-maxiter <maxiter>]	maximum EM iterations to run
#	[-distance <distance>]	EM convergence criterion
#	[-psp <pspfile>]	name of positional priors file
#	[-prior dirichlet|dmix|mega|megap|addone] type of prior to use
#	[-b <b>]		strength of the prior
#	[-plib <plib>]		name of Dirichlet prior file
#	[-maxwords <maxwords>]	maximum number of words to test as EM starts
#	[-spfuzz <spfuzz>]	fuzziness of sequence to theta mapping
#	[-spmap uni|pam]	starting point seq to theta mapping type
#	[-cons <cons>]		consensus sequence to start EM from
#	[-heapsize <hs>]	size of heaps for widths where substring search occurs
#	[-x_branch]		perform x-branching
#	[-w_branch]		perform width branching
#	[-allw]			include all motif widths from min to max
#	[-bfactor <bf>]		branching factor for branching search
#	[-maxsize <maxsize>]	maximum dataset size in characters
#	[-nostatus]		do not print progress reports to terminal
#	[-p <np>]		use parallel version with <np> processors
#	[-time <t>]		quit before <t> CPU seconds consumed
#	[-sf <sf>]		print <sf> as name of sequence file
#	[-V]			verbose mode
#	[-version]		display the version number and exit
-----------------------------------------------------------
# GOMo(gene ontology for motifs)
'''
Starting ama
ama --pvalues --verbosity 1 motifs.meme db/plant_arabidopsis_1000_199.na db/plant_arabidopsis_1000_199.na.bfile
ama ran successfully in 6 seconds
Starting ama
ama --pvalues --verbosity 1 motifs.meme db/plant_oryza_sativa_1000_199.na db/plant_oryza_sativa_1000_199.na.bfile
ama ran successfully in 1.82 seconds
Starting ama
ama --pvalues --verbosity 1 motifs.meme db/plant_populus_trichocarpa_1000_199.na db/plant_populus_trichocarpa_1000_199.na.bfile
ama ran successfully in 1.71 seconds
Starting ama
ama --pvalues --verbosity 1 motifs.meme db/plant_sorghum_brachupodium_1000_199.na db/plant_sorghum_brachupodium_1000_199.na.bfile
ama ran successfully in 1.83 seconds
Starting ama
ama --pvalues --verbosity 1 motifs.meme db/plant_brachypodium_1000_199.na db/plant_brachypodium_1000_199.na.bfile
ama ran successfully in 1.61 seconds
Starting gomo
gomo --nostatus --verbosity 1 --oc . --t 0.05 --shuffle_scores 1000 --dag db/go.dag --motifs motifs.meme db/plant_arabidopsis_1000_199.na.csv plant_arabidopsis_1000_199.na.cisml plant_oryza_sativa_1000_199.na.cisml plant_populus_trichocarpa_1000_199.na.cisml plant_sorghum_brachupodium_1000_199.na.cisml plant_brachypodium_1000_199.na.cisml
gomo ran successfully in 14.21 seconds
Running gzip on CISML files
Starting gzip
gzip plant_arabidopsis_1000_199.na.cisml
gzip ran successfully in 0.12 seconds
Starting gzip
gzip plant_oryza_sativa_1000_199.na.cisml
gzip ran successfully in 0.04 seconds
Starting gzip
gzip plant_populus_trichocarpa_1000_199.na.cisml
gzip ran successfully in 0.04 seconds
Starting gzip
gzip plant_sorghum_brachupodium_1000_199.na.cisml
gzip ran successfully in 0.04 seconds
Starting gzip
gzip plant_brachypodium_1000_199.na.cisml
gzip ran successfully in 0.04 seconds
Done
'''
gomo --nostatus --verbosity 1 --oc . --t 0.05 --shuffle_scores 1000 --dag db/go.dag --motifs motifs.meme db/plant_arabidopsis_1000_199.na.csv plant_arabidopsis_1000_199.na.cisml plant_oryza_sativa_1000_199.na.cisml plant_populus_trichocarpa_1000_199.na.cisml plant_sorghum_brachupodium_1000_199.na.cisml plant_brachypodium_1000_199.na.cisml

















