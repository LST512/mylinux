for i in `ls`; do mv $i `echo $i | sed 's/oldstring/newstring/'`;  done  
ls |while read id;do echo $id;mv $id `echo $id|sed -e 's/.noip//g' -e 's/-/_/g'`;done


#名字有空格的（tbtool韦恩图得到的）第一种无法用，第二种可以
ls stage.1.4up\ x\ 1.4md.and.3.5up\ x\ 3.5md.and.12up\ x\ 12md.common.3.txt|while read id
do
echo $id
mv $id lengthening.${id#.*}
done

ls |while read id 
do
echo $id
mv $id lengthening.${id#*.}
done

