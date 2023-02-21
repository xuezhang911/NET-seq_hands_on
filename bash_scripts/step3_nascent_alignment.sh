#!/bin/bash -l
#SBATCH -A snic2022-22-89
#SBATCH -p core
#SBATCH -n 20
#SBATCH -t 72:00:00
#SBATCH -J alignment
#SBATCH --mail-user xue.zhang@slu.se
#SBATCH --mail-type=ALL
module load bioinfo-tools star/2.7.9a
cd /crex/proj/snic2021-23-14/Xue/NET-seq_nf/fastp
for i in $(find .  -name "*.trimmed_2.fastp.fastq.gz");
do
echo $i
a1=$(basename ${i/.trimmed_2.fastp.fastq.gz/})
echo $a1
STAR --genomeDir /crex/proj/snic2021-23-14/Xue/Genome \
--readFilesIn $i \
--readFilesCommand zcat \
--runThreadN 6 \
--outFileNamePrefix /crex/proj/snic2021-23-14/Xue/NET-seq_nf/alignment/$a1 \
--outSAMmultNmax 1 \
--alignEndsType Extend5pOfRead1 \
--outSAMtype BAM Unsorted \
--outSAMstrandField intronMotif
done