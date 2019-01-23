#建立blast本地数据库
makeblastdb -in Spatina.fasta -dbtype nucl -out Spatinadb
makeblastdb -in fipv_aa.fa -dbtype prot -out fipv_aa_db
#比对参数
blastn -query 1.txt -db Spatinadb -out 2.txt
blastp -query aa.txt -db fipv_aa_db -out aa_res.txt
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 1 -out spartina_transcript_blast_tair.txt &
blastp -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
nohup blastp -query transcript_ORF.txt -db tair10_AAdb -num_alignments 0 -num_descriptions 1 -num_threads 4 -out spartina_transcript_blast_tair.txt &
tblastn -query al_AA.txt -db ChinafirCDS -num_threads 4 -out al_tblastn.txt
------------------------------
blastp：蛋白序列与蛋白库做比对。
blastx：核酸序列对蛋白库的比对。
blastn：核酸序列对核酸库的比对。
tblastn：蛋白序列对核酸库的比对。
tblastx：核酸序列对核酸库在蛋白级别的比对
______________________________
2018-8-3更新
用-num_alignments 1 参数只显示一条
用-outfmt 5 参数输出xml格式
用tbtools转换为表格
blastp -query test.fa -db tair10_AAdb -num_alignments 1 -outfmt 5 -num_threads 4 -out test.xml
-----------------------populus
nohup blastp -query orf_chinafir_FLT_trans.fa -db populus_aa_db -num_alignments 1 -outfmt 5 -num_threads 2 -out ChinaFir_blast2populus.xml &
-----------------------rice orz
nohup blastp -query orf_chinafir_FLT_trans.fa -db orz_db -num_alignments 1 -outfmt 5 -num_threads 2 -out ChinaFir_blast2rice.xml & 
------------------------------
#其他参数
blastn -help
blastp -help
-num_descriptions 5	#保留5条，比对到的id
-num_alignments 2	#保留2条,详细的比对情况
-outfmt 7	#显示格式，默认同网络版
-query： 输入文件路径及文件名
-out：输出文件路径及文件名
-evalue: 例如1e-5
-db：格式化了的数据库路径及数据库名
-evalue：设置输出结果的e-value值
-num_threads：线程数
-max_target_seqs：最多允许比对到数据库中的序列数目，参数仅适用于outfmt >4。
-outfmt：输出文件格式，总共有12种格式，6是tabular格式对应BLAST的m8格式
0 = pairwise,
1 = query-anchored showing identities,
2 = query-anchored no identities,
3 = flat query-anchored, show identities,
4 = flat query-anchored, no identities,
5 = XML Blast output,
6 = tabular,
7 = tabular with comment lines,
8 = Text ASN.1,9 = Binary ASN.1,
10 = Comma-separated values,
11 = BLAST archive format (ASN.1),
12 = JSON Seqalign output,
13 = JSON Blast output,
14 = XML2 Blast output
