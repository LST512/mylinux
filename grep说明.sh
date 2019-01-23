#grep 用法
#author：lst
#date：2018-4-27
-----------------------------------------
-----------------------------------------
# 统计文本中特定字符的个数
cat arab_tair10.t_gff10_org.CDS.coord.fa|grep -v '>'|grep -o 'A'|wc -l
grep -o "A" file|wc -l
grep -o "ATCG" file|wc -l
# 统计文本中出现特定字符的行数
grep -c "A" file
grep -c "ATCG" file
#打印某个字母并显示行号，w表示精确匹配
grep -wn 'scaffold_21' Glycine_max.Glycine_max_v2.0.dna.chromosome.1.fa

