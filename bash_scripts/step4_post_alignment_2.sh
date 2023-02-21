#!/bin/bash -l
#SBATCH -A snic2022-22-89
#SBATCH -p core
#SBATCH -n 20
#SBATCH -t 72:00:00
#SBATCH -J post_alignment
#SBATCH --mail-user xue.zhang@slu.se
#SBATCH --mail-type=ALL
module load bioinfo-tools samtools/1.16 umi_tools/1.0.0 BEDTools/2.29.2
cd /crex/proj/snic2021-23-14/Xue/NET-seq_nf/alignment
for i in $(find .  -name "*_dedup.bam");
do
echo $i
a1=$(basename ${i/_dedup.bam/})
echo $a1

# mannually delete the header of bam file the number 62 is variable depends ondifferent file sed -i "1,62d" ${a1}_dedup.bam some files have no information
# step4 remove unwanted gene list
bedtools intersect -v -a ${a1}_dedup.bam -b /crex/proj/snic2021-23-14/Xue/genome/Unwanted.bed -ubam  > ${a1}_dedup_clean.bam
# step5 Remove low MAPQ reads eith samtools
samtools view -hb -q 10 ${a1}_dedup_clean.bam > ${a1}_dedup_clean_mapq.bam
samtools flagstat ${a1}_dedup_clean_mapq.bam > ${a1}_dedup_clean_mapq.bam.stat
done


