#conda 安装与配置 linux
# by lst
# 2018-8-23
# download conda(miniconda is ok)
https://conda.io/miniconda.html
# install miniconda(when asked ,choose yes)
sh miniconda.sh
# config miniconda add tsinghua channels
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
conda config --set show_channel_urls yes
# conda update conda
conda update -n base conda
# clean
conda clean --all
#########################
#biosoft
#########################
# create env
conda create -n biosoft
# remove
conda remove -n biosoft
# use biosoft
source activate biosoft
source deactivate
# install packages from bioconda
#http://bioconda.github.io/recipes.html
conda install fastqc multiqc hisat2 star samtools bedtools blast trimmomatic sra-tools meme trim-galore homer
conda install bioconductor-deseq2 bioconductor-clusterprofiler bioconductor-edger
conda install -c r rstudio 
apt install texlive-xetex # multiqc to generate pdf
# 非必要；修改multiqc内容，添加'-V', 'mainfont=Ubuntu Mono'，解决
#Missing character: There is no ≥ in font [lmroman10-regular]:mapping=tex-text;!
###################################
#configure rstudio with a shell script
##################################
# RSTUDIO_WHICH_R important parameter
export RSTUDIO_WHICH_R=/home/lst/miniconda3/envs/biosoft/bin/R
nohup /home/lst/miniconda3/envs/biosoft/bin/rstudio  &
################################
#pas-seq
################################
conda create -n PasSeq
#conda search mysql perl
conda install bioconductor-deseq2 bioconductor-clusterprofiler bioconductor-edger r-ggplot2 r-rjdbc r-xml r-dplyr
conda install -c bioconda r-calibrate
conda install mysql
conda install perl-bioperl
conda install perl perl-dbi perl-list-moreutils perl-xml-parser perl-xml-simple perl-time-local perl-dbi perl-dbd-mysql perl-exporter-tiny 
#conda install -c bioconda perl-cpan-shell 
conda install perl-dbi perl-list-moreutils perl-xml-parser perl-xml-simple perl-time-local perl-dbi perl-dbd-mysql perl-exporter-tiny
#conda install -c bioconda perl-dbd-mysql
# conda需要把#!/usr/bin/perl -w改成#!/home/lst/miniconda3/envs/PasSeq/bin/perl -w 
# configure mysql
#mysql_install_db 用新的mysqld --initialize替换
'''
--user  启动mysql的用户
--basedir  mysql安装目录
--datadir  mysql数据仓库目录
'''
# 输出的内容会最后有root密码，记下，后面登录要修改密码才能用。
mysqld --initialize --user=lst --basedir=/home/lst/miniconda3/envs/PasSeq --datadir=/home/lst/miniconda3/envs/PasSeq/data
mysql.server {start|stop|restart|reload|force-reload|status}  
# 登录mysql并且修改密码:xfdojPo,Q6Vz
mysql -u root -p
set password = password('512513');
#Can't find error-message file errmsg.sys 解决办法
cp /home/lst/miniconda3/envs/PasSeq/share/mysql/english/errmsg.sys /home/lst/miniconda3/envs/PasSeq/errmsg.sys
#MySQL server has gone away
show global variables like 'max_allowed_packet';
set global max_allowed_packet=1024*1024*160;
show global variables like 'secure_file_priv';
set global secure_file_priv=;
#show global variables like 'wait_timeout';
#set global wait_timeout=288000000;
#show global variables like 'innodb_lock_wait_timeout';
#set global innodb_lock_wait_timeout=288000000;
#show global variables like 'lock_wait_timeout';
#set global lock_wait_timeout=288000000;
#解决secure_file_priv
my_print_defaults --help #查看配置文件
建立/home/lst/miniconda3/envs/PasSeq/etc/my.cnf 
chmod 644 my.cnf（777会有安全问题，不被执行）
-------------------------------------------------------------
count(*) 相当于统计行数
# 导出数据库,密码可不直接写，enter后会提示输入
# 导出数据
mysqldump -uroot -p databasesname
mysqldump -uroot -p dbname tableName >db.sql;
mysqldump -u用户名 -p密码 数据库名 表名 --where="筛选条件" > 导出文件路径
mysqldump --max_allowed_packet=512M -u root -p database 
#导出整个数据库结构和数据
mysqldump -h localhost -uroot -p123456 database > dump.sql
#导出单个数据表结构和数据
mysqldump -h localhost -uroot -p  database table > dump.sql
#导出整个数据库结构（不包含数据）
mysqldump -h localhost -uroot -p  -d database > dump.sql
#导出单个数据表结构（不包含数据）
mysqldump -h localhost -uroot -p  -d database table > dump.sql
# 导出文本
mysql -uroot -pmapolya tair10 -e "select * from 6BA_esp_amp_PAC where tot_tagnum >=5 into outfile '/home/polya/NGS/second_data/sql_data/PAC/6BA_esp_amp_PAC.txt';"
---------------------------------------------------------------------------
mysqldump -uroot -p -d tair10 AN3661_col0_PAC > an3661_col0_pac_struc.sql
#excel保存为txt
#导出数据直接处理，如果用excel保存为txt则变为'\r\n'
source /home/lst/NGS/second_PAC_results/AN3661/an3661_col0_pac_struc.sql;
mysql -uroot -p512513 nor_PAC --local-infile=1 -e "load data local infile '/home/lst/NGS/second_PAC_results/AN3661/AN3661_col0_PAC_nor.txt' into table AN3661_col0_PAC lines terminated by '\n'";
mysql -uroot -p512513 nor_PAC --local-infile=1 -e "load data local infile '/home/lst/NGS/second_PAC_results/AN3661/data/AN3661_col0_PAC_nor_NA.trim.txt' into table AN3661_col0_PAC_nor lines terminated by '\n'";

select * from AN3661_col0_PAC into outfile '/home/lst/NGS/second_PAC_results/AN3661/test.txt';
alter table test rename test1; --修改表名
alter table test add  column name varchar(10); --添加表列
alter table test drop  column name; --删除表列
alter table test modify address char(10) --修改表列类型
alter table test change address address  char(40)
alter table test change  column address address1 varchar(30)--修改表列名
--------------------------------------------------------------
#conda 备份环境
source activate biosoft
conda env export > environment.yml
conda env create -f environment.yml
