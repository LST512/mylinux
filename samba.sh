#samba服务创建
#1.安装Samba
sudo apt install samba samba-common
#2.创建共享文件夹，如在home下创建share文件夹
mkdir share
chmod 777 share
#3.修改samba的配置文件
sudo vim /etc/samba/smb.conf
最后添加内容：
[share]
	path = /home/share
	available = yes
	browseable = yes
	writable = yes
	#public = yes 不需要密码
#4.创建samba账户
sudo touch /etc/samba/smbpasswd
sudo smbpasswd -a lst#输入要创建的密码
#5.重启samba服务
sudo /etc/init.d/smbd restart 
#


