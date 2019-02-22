#杉木序列提取
#2019-2-20
#lst
#位点格式分离
cat raw_xylem_vs_phloem.annotation.tsv|awk -F, '{print $1"\t"$2}' > xylem_vs_phloem.annotation.tsv
#调整顺序，避免pos1比pos2大，excel用if判断调整
#pos1-100,pos2+100
cat xylem_vs_phloem.annotation.tsv|awk '{OFS="\t"}{$7=$7-1000;$8=$8+1000;print $0}' > xylem_vs_phloem.annotation_modify.tsv
#构造格式
cat xylem_vs_phloem.annotation_modify.tsv|awk '{print $3":"$7"-"$8}'|sed -r "/Chromo/d" > xylem_vs_phloem.annotation_modify_struc.tsv
#提取
samtools faidx genome.fa
cat xylem_vs_phloem.annotation_modify_struc.tsv|while read id
do
samtools faidx Cunninghamia_lanceolata_V1.fasta $id >> xylem_vs_phloem.annotation_sequence_1000.fa
done
