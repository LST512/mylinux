###
mysql 操作命令
###
#安装
sudo apt install mysql-server 
sudo apt install libdbd-mysql-perl	#5.7版本可能要安装，如果出现DBD::mysql加载错误。
#linux
sudo /etc/init.d/mysql star|stop|restart
sudo service mysql star|stop|restart
#存放的数据所在的文件夹设置权限(Errcode 13)
gedit /etc/apparmor.d/usr.sbin.mysqld #比如文件夹为 /data/设置为--> /data/ r,/data/* rw
#mysql 命令
mysql -h主机地址 -u用户名 －p用户密码
mysql -u root -p #以root身份登录，输入密码
mysqladmin -uroot -p123 password 456 #修改密码123为456
###########################
增加可以登录mysql用户，先以root登录
这些用户可以登录数据库
区别与数据库里面添加用户
#############################
grant select,insert,update,delete on *.* to test1@"%" identified by "abc"; #增加一个名为test1密码为abc，可以在任何主机上登录，对所有数据库具有查看、插入、修改、删除的权限。
grant select,insert,update,delete on mydb.* to test2@localhost identified by \"abc\"; #增加一个用户test2密码为abc,让他只可以在localhost上登录，并可以对数据库mydb进行查询、插入、修改、删除的操作(localhost指本地主机，即MYSQL数据库所在的那台主机)
grant select,insert,update,delete on mydb.* to test2@localhost identified by \"\"; # 如果你不想test2有密码，可以再打一个命令将密码消掉。
Delete FROM user Where User='test' and Host='localhost'; #删除用户
flush privileges;
#mysql数据库操作需要以；结尾
#####################
数据库里面添加用户
先以root身份登录
######################
#创建用户
insert into mysql.user(Host,User,Password) values("localhost","test",password("1234")); #创建名为test密码为1234的用户，localhost指只能在本地登录，需要远程修改为%，都可以登录。
#用户授权 grant 权限 on 数据库.* to 用户名@登录主机 identified by "密码";
grant all privileges on testdb.* to test@localhost identified by "1234";
flush privileges; #刷新系统权限表
# 指定部分权限
grant select,update on testdb.* to test@localhost iddentified by "1234";
flush privileges;
#授予test用户拥有所有数据库的某些权限
grant select,update,delete,creat,drop on *.* to test@"%" identified by "1234";
#删除账户及权限：
>drop user 用户名@'%';
>drop user 用户名@ localhost; 

###############
修改用户密码
###############
update mysql.user set password=password('新密码') where User="test" and Host="localhost";
flush privileges;
--------------------------------------------------------------
show databases;	#显示数据库
create database xxx;	#创建一个名字为xxx的数据库
use xxx;	#使用某个数据库
show tables;	#显示当前数据库下的表
drop database xxx;	#删除xxx数据库
drop table tableName;	#删除表
describe tableName;	#(或者简写: desc tableName;)显示表结构
insert into tableName(id,name...) values('1','admin',...);	#向表中添加数据
select * from tableName;	#查看所有内容
delete from tableName;	#删除表中数据，表结构还在
update tableName set name='administrator' where id='1'; 	#更新表中的数据，没有where，影响所有记录
select version(),current_date; #查看服务器版本和当前日期
select version(); #查看服务器版本
select now(); #查看服务器日期
select user(); #查看用户
#将数据库abc导入xxx
creat database xxx;
use xxx;
source abc.sql
#实例
select chr from t_gff10_ae120pm2k;
#统计有多少染色体
select count(title) from chromosome;
#显示染色体名称
select title from chromosome;
#定位到 MySQL 数据文件的存储位置方法
show global variables like "%datadir%";
show variables like '%secure%';
/var/lib/mysql/db_bamboo


STAR --runThreadN 15 --outSAMtype BAM SortedByCoordinate --genomeDir $star_index --readFilesIn $id --outFileNamePrefix $output/





