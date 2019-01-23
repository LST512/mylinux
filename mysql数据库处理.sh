#!/bin/bash
source activate PasSeq
################# 导出AN3661与amp，esp5的原始PAC表
path2=/home/polya/NGS/second_data/sql_data/struc
# 6BA下
mysql -uroot -pmapolya tair10 -e "select * from 6BA_esp5_amp_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/6BA_esp5_amp_PAC.txt';"
#DMSO下
mysql -uroot -pmapolya tair10 -e "select * from DMSO_esp5_amp_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/DMSO_esp5_amp_PAC.txt';"
# amp在6BA、DMSO下
mysql -uroot -pmapolya tair10 -e "select * from amp_6BA_DMSO_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/amp_6BA_DMSO_PAC.txt';"
# esp5在6BA、DMSO下
mysql -uroot -pmapolya tair10 -e "select * from esp5_6BA_DMSO_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/esp5_6BA_DMSO_PAC.txt';"
# AN3661
mysql -uroot -pmapolya tair10 -e "select * from AN3661_col0_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/AN3661_col0_PAC.txt';"
################导出AN3661与amp，esp5的原始PAC表结构;修改原始PAC表结构，修改为nor
# 6BA下
mysqldump -uroot -pmapolya -d tair10 6BA_esp5_amp_PAC|sed 's/6BA_esp5_amp_PAC/6BA_esp5_amp_PAC_nor/g' > $path2/6BA_esp5_amp_PAC_nor.sql;
#DMSO下
mysqldump -uroot -pmapolya -d tair10 DMSO_esp5_amp_PAC|sed 's/DMSO_esp5_amp_PAC/DMSO_esp5_amp_PAC_nor/g' > $path2/DMSO_esp5_amp_PAC_nor.sql;
# amp在6BA、DMSO下
mysqldump -uroot -pmapolya -d tair10 amp_6BA_DMSO_PAC|sed 's/amp_6BA_DMSO_PAC/amp_6BA_DMSO_PAC_nor/g' > $path2/amp_6BA_DMSO_PAC_nor.sql;
# esp5在6BA、DMSO下
mysqldump -uroot -pmapolya -d tair10 esp5_6BA_DMSO_PAC|sed 's/esp5_6BA_DMSO_PAC/esp5_6BA_DMSO_PAC_nor/g' > $path2/esp5_6BA_DMSO_PAC_nor.sql;
# AN3661
mysqldump -uroot -pmapolya -d tair10 AN3661_col0_PAC|sed 's/AN3661_col0_PAC/AN3661_col0_PAC_nor/g' > $path2/AN3661_col0_PAC_nor.sql;
################;导入到数据库
cd $path2
ls *.sql|while read id;do echo $id;mysql -uroot -pmapolya tair10 < $id;done


