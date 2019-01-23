sort命令格式如下：

        samtools sort [-l level] [-m maxMem] [-o out.bam] [-O format] [-n] [-T tmpprefix] [-@ threads] [in.sam|in.bam|in.cram]

        参数：

                   -l INT 设置输出文件压缩等级。0-9，0是不压缩，9是压缩等级最高。不设置此参数时，使用默认压缩等级；

                   -m INT 设置每个线程运行时的内存大小，可以使用K，M和G表示内存大小。

                   -n 设置按照read名称进行排序；

                   -o FILE 设置最终排序后的输出文件名；

                   -O FORMAT 设置最终输出的文件格式，可以是bam，sam或者cram，默认为bam；

                   -T PREFIX 设置临时文件的前缀；

                   -@ INT 设置排序和压缩是的线程数量，默认是单线程。

       下图为一个sort命令的使用实例。其中，压缩等级设置为最高级9，为每一个线程设置的内存为90M，同时设置了输出文件名，临时文件的前缀和线程数。
samtools sort -l 9 -m 200M -o SRR609268.fastq.sam.bam_sorted -T sorted -@ 2 SRR609268.fastq.sam.bam
nohup samtools sort -l 9 -m 500M -o athb25_59.bam_sorted -T athb25_59.bam_un -@ 2 athb25_59.bam &

