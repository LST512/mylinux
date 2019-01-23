#!/usr/bin
# mydeepin configure
# install packages
sudo apt install openssh-server curl zsh git proxychains4
wget http://file.lolimay.cn/shadowsocks-deepin_1.2.2_amd64.deb
sudo dpkg -i shadowsocks-deepin_1.2.2_amd64.deb
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# tampermonkey script install
'''
AC-baidu
CNKI PDF Download
sci-hub button
userscript+
vip
划词翻译
视频网页全屏
'''
# source-code-fonts;自己备份的
# 安装iNodeClient
# 修改install.sh适合deepin，以及init.d的脚本加入rc.d
sudo cp iNodeClient_Linux64.tar.gz /usr
sudo su
tar -xvf iNodeClient_Linux64.tar.gz
chmod -R 777 iNodeClient
cd iNodeClient
cd /etc/init.d/
service iNodeAuthService start
sudo chkconfig iNodeAuthService on
chkconfig --list
#install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh
#############################
# baidupcsGO
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
#conda update -n base conda
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
conda install fastqc hisat2 star samtools bedtools blast trimmomatic sra-tools meme trim-galore homer

#创建第二个环境，避免依赖冲突
conda create -n PasSeq
conda install bioconductor-deseq2 bioconductor-clusterprofiler bioconductor-edger r-ggplot2 r-rjdbc r-xml r-dplyr
conda install -c r rstudio 
conda install -c bioconda r-calibrate
conda install -c anaconda mysql
conda install perl perl-bioperl perl-dbi perl-list-moreutils perl-xml-parser perl-xml-simple perl-time-local perl-dbi perl-dbd-mysql perl-exporter-tiny  
#单独安装mysql，
# my_print_defaults --help #查看配置文件
# my.cnf
'''
[mysqld]
max_allowed_packet	= 150M
secure_file_priv	=
'''
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
# PasSeq 流程
# 把所有脚本放到myperl文件夹，然后放到conda的PasSeq环境下，ln -s软连接到PaSseq/bin,funclib放一份到lib的perl下。
‘’‘
#!/home/lst/miniconda2/envs/PasSeq/bin/perl -w
#测试是否配置成功
use strict;
use Getopt::Long
require ('funclib.pl');
print "hello\n"
’‘’
#mysql命令
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
#mysql数据库的恢复;
mysqldump -uroot -pmapolya tair10 AN3661_PAC > AN3661_PAC.SQL
mysqldump -uroot -pmapolya tair10 AN3661_col0_PAC > AN3661_col0_PAC.SQL
mysqldump -uroot -pmapolya tair10 AN3661_col0_PAC_nor > AN3661_col0_PAC_nor.SQL
mysqldump -uroot -pmapolya tair10 col0_PAC > col0_PAC.SQL
mysqldump -uroot -pmapolya tair10 chromosome > chromosome.SQL#太大无法导出
mysqldump -uroot -pmapolya tair10 t_gff10_ae120pm2k > t_gff10_ae120pm2k.SQL
mysqldump -uroot -pmapolya tair10 t_gff10_org > t_gff10_org.SQL
mysqldump -uroot -pmapolya tair10 seq2_PA > seq2_PA.SQL
#下载
scp -P 22 * lst@59.79.232.157:/home/lst/Desktop/AN3661_SQL
#导入到本地电脑
ls *.SQL|while read id;do echo $id;mysql -uroot -p512513 tair10 < $id;done
#操作
alter table test rename test1; --修改表名
alter table test add  column name varchar(10); --添加表列
alter table test drop  column name; --删除表列
alter table test modify address char(10) --修改表列类型
alter table test change address address  char(40)
alter table test change  column address address1 varchar(30)--修改表列名
#获取表结构
mysqldump -uroot -p512513 -d tair10 AN_PAC > AN_PAC_tablestruc.sql
mysqldump -uroot -p512513 -d tair10 col0_PAC > col0_PAC_tablestruc.sql
sed -i 's/AN_PAC/AN_PAC_nor/g' AN_PAC_tablestruc.sql
sed -i 's/col0_PAC/col0_PAC_nor/g' col0_PAC_tablestruc.sql
mysql -uroot -p512513 tair10 < AN_PAC_tablestruc.sql
mysql -uroot -p512513 tair10 < col0_PAC_tablestruc.sql
#导入均已化后的数据
mysql -uroot -p512513 tair10 --local-infile=1 -e "load data local infile '/home/lst/Desktop/AN3661_SQL/AN_pac_raw10_nor.txt' into table AN_PAC_nor lines terminated by '\n'";
mysql -uroot -p512513 tair10 --local-infile=1 -e "load data local infile '/home/lst/Desktop/AN3661_SQL/colo_pac_raw10_nor.txt' into table col0_PAC_nor lines terminated by '\n'";
#备份数据
mysqldump -uroot -p512513 tair10 AN_PAC_nor > AN_PAC_nor.SQL
mysqldump -uroot -p512513 tair10 col0_PAC_nor > col0_PAC_nor.SQL
#挂载,事先不能挂载
mount /dev/sda8 /home/lst/data
umount /dev/sda8
umount -l /mnt/hda5
-----------------------------------------------------------------------
#解决rstudio无法中文的问题,不适用conda安装的;https://bbs.pinggu.org/thread-5936604-1-1.html
'''
wget http://ikuya.info/tmp/fcitx-qt5-rstudio.tar.gz 
tar xf fcitx-qt5-rstudio.tar.gz 
cd fcitx-qt5-rstudio 
sudo apt install ./fcitx-frontend-qt5-rstudio_1.0.5-1_amd64.deb ./libfcitx-qt5-1-rstudio_1.0.5-1_amd64.deb 
'''
#如果提示依赖，解压deb包，复制文件到
dpkg-deb -R  fcitx-frontend-qt5-rstudio_1.0.5-1_amd64.deb    fcitx-frontend-qt5-rstudio
#把解压出来的文件fcitx-frontend-qt5-rstudio/usr/lib/rstudio/bin/plugins/#platforminputcontexts/下的对应文件拷贝到系统/usr/lib/rstudio/目录下面对应的位置，
#然后再解压第二个#deb包
dpkg-deb -R  libfcitx-qt5-1-rstudio_1.0.5-1_amd64.deb  libfcitx-qt5-rstudio
#把解压目录对应的libfcitx-qt5-rstudio/usr/lib/rstudio/bin里面的四个文件拷贝到/usr/lib/rstudio/#bin目录下（新版本的Rstudio可能已经有这四个文件了），重新启动rstudio即可。
-------------------------------------------------------------------------------------


