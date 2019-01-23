#########################################
#Using STAR to map 
#website:https://github.com/alexdobin/STAR
#workflow by lst
#date 2018-3-29
########################################

###########################
#step1 download and install
###########################
'''
STAR website: https://github.com/alexdobin/STAR;
Using pre-compiled executables or compling from source.
see https://github.com/alexdobin/STAR/tree/master/doc
'''
###########################
#step2 make index
###########################
'''
#require: genome.fa(include chromosomes);Annotations(gtf/gff)
#notice:chromosome names in the annotations GTF file have to match chromosome names in the FASTA genome sequence files
		ENSEMBL FASTA files with ENSEMBL GTF files, and UCSC FASTA files with UCSC FASTA files
#examples:ENSEMBL: files marked with .dna.primary.assembly----> dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
		 NCBI: no alternative - analysis set------>GRCh38_no_alt_analysis_set.fna.gz
'''
####### make index
#--runThreadN defines the number of threads to be used for genome generation.
#--runMode genomeGenerate directs STAR to run genome indices generation job.
#--genomeDir path to the directory where the genome indices are stored.This directory has to be created (with mkdir) before STAR run and needs to writing permissions. 
#--genomeFastaFiles one or more FASTA files with the genome reference sequences.
#--sjdbGTFfile path to the transcript annotation in the standard GTF format.
#STAR --runThreadN 6 --runMode genomeGenerate --genomeDir STAR_index --genomeFastaFiles tair10_ensemble.fa --sjdbGTFtagExonParentTranscript tair10_ensemble.gff3(not test)
#--limitGenomeGenerateRAM：maximum available RAM (bytes) for genome generation
STAR --runThreadN 6 --limitGenomeGenerateRAM 10000000000 --runMode genomeGenerate --genomeDir STAR_index --genomeFastaFiles tair10_ensemble.fa --sjdbGTFfile tair10_ensemble.gtf
####### mapping
# (*.gz) use --readFilesCommand zcat OR --readFilesCommand gunzip -c. For bzip2-compressed files, use --readFilesCommand bunzip2 -c.
# Multiple samples can be mapped in one job
# single-end  --readFilesIn sample1.fq,sample2.fq,sample3.fq 
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir ./STAR_index --readFilesIn sample1.fq,sample2.fq,sample3.fq --outFileNamePrefix output/c0h
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --genomeDir ./STAR_index --readFilesCommand zcat --readFilesIn c0h.fastq.gz --outFileNamePrefix output/c0h
#paired-end  --readFilesIn sample1read1.fq,sample2read1.fq,sample3read1.fq sample1read2.fq,sample2read2.fq,sample3read2.fq
STAR --runThreadN 6 --outSAMtype BAM SortedByCoordinate --limitBAMsortRAM 200000000 --genomeDir ./STAR_index --readFilesCommand zcat --readFilesIn col0_1.fastq.gz col0_2.fastq.gz --outFileNamePrefix output/col0
'''
We will use the STAR package with the mode "genomeGenerate" to create our index files. Our peach genome is ~230Mb, and takes about 10 min to generate the index files.

/lustre/medusa/proj/UT-TNEDU0031/software/STAR-2.5.3a/STAR \
--runMode genomeGenerate \
--genomeDir . \
--genomeFastaFiles Ppersica_298_v2.0.fa \
--runThreadN 1 \
--sjdbGTFfile Ppersica_298_v2.1.gene_exons.gff3 \
--sjdbGTFtagExonParentTranscript Parent \
--sjdbOverhang 49
What do all those flags mean?
runMode genomeGenerate - We want to generate index files for a genome.
genomeDir . - We want to generate those new files in the current directory.
genomeFastaFiles Ppersica_298_v2.0.fa - This is the name of the fasta file that holds the genome in fasta format.
runThreadN 1 - Use a single thread (ie CPU core) to run this job. (Increase if you have more resources!)
sjdbGTFfile Ppersica_298_v2.1.gene_exons.gff3 - This is the name of the gff file that holds the gene annotations.
sjdbGTFtagExonParentTranscript Parent - For GFF3 formatted annotations we need to use this flag. If the annotation is in GTF format, we dont need it.
sjdbOverhang 49 - This should be set to read length - 1
'''
########################
P_heterocycla
#######################
index
######################
STAR --runThreadN 6 \
--limitGenomeGenerateRAM 8000000000 \
--genomeChrBinNbits 2 \
--genomeSAsparseD 5 \
--runMode genomeGenerate \
--genomeDir STAR_index \
--genomeFastaFiles P_heterocycla.fa \
--sjdbGTFfile P_heterocycla_v1.0.genemodel.gff3 \
--sjdbGTFtagExonParentTranscript Parent \
--sjdbOverhang 74
######################
STAR --runThreadN 6 \
--outSAMtype BAM SortedByCoordinate \
--limitBAMsortRAM 200000000 \
--genomeDir ./STAR_index \
--readFilesCommand zcat --readFilesIn Pe22mixR1-1_L1_A001.R1.clean.fastq \
--outFileNamePrefix output/






