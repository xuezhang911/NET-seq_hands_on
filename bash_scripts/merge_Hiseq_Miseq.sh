#!/bin/bash -l
#SBATCH -A snic2022-22-89
#SBATCH -p core
#SBATCH -n 5
#SBATCH -t 72:00:00
#SBATCH -J merge
#SBATCH --mail-user xue.zhang@slu.se
#SBATCH --mail-type=ALL
# rename all files with sample name mv SRR9117181_dedup_clean_mapq.bam Miseq_12h2_mapq.bam
module load bioinfo-tools samtools/1.16
cd /crex/proj/snic2021-23-14/Xue/NET-seq_nf/post_alignment
for f1 in $(find .  -name "Hiseq*mapq.bam");
do
echo $f1
f2=${f1/Hiseq/Miseq}
echo $f2
samtools merge -o ${f2/Miseq/full} $f1 $f2
done