#将整个 /etc 目录下的文件全部打包成为 /tmp/etc.tar
tar -cvf /tmp/etc.tar /etc <==仅打包，不压缩！
tar -zcvf /tmp/etc.tar.gz /etc <==打包后，以 gzip 压缩
tar -jcvf /tmp/etc.tar.bz2 /etc <==打包后，以 bzip2 压缩
-----------------------------------------------------------
#查阅上述 /tmp/etc.tar.gz 文件内有哪些文件
tar -ztvf /tmp/etc.tar.gz
------------------------------------------------------------
#将 /tmp/etc.tar.gz 文件解压缩在 /usr/local/src 下
cd /usr/local/src
tar -zxvf /tmp/etc.tar.gz
------------------------------------------------------------
#将 /etc/ 内的所有文件备份下来，并且保存其权限！
tar -zxvpf /tmp/etc.tar.gz /etc
-------------------------------------------------------------
#在 /home 当中，比 2005/06/01 新的文件才备份
tar -N '2005/06/01' -zcvf home.tar.gz /home
#备份 /home, /etc ，但不要 /home/dmtsai
tar --exclude /home/dmtsai -zcvf myfile.tar.gz /home/* /etc
#将 /etc/ 打包后直接解开在 /tmp 底下，而不产生文件！
cd /tmp
tar -cvf - /etc | tar -xvf -




