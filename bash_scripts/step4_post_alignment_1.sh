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
for i in $(find .  -name "*Aligned.out.bam");
do
echo $i
a1=$(basename ${i/Aligned.out.bam/})
echo $a1
#step1 sort the file with samtools
samtools sort -m 1G -@ 24 $i -o ${a1}_sorted.bam
samtools index ${a1}_sorted.bam
#step2 remove duplicate reads samtools markdup -r ${a1}_sorted.bam ${a1}_rmdup.bam samtools index ${a1}_rmdup.bam not necessary
#step3 UMI-tools dedup remove pcr duplicates
umi_tools dedup --stdin=${a1}_sorted.bam  > ${a1}_dedup.bam
done
# need to remove some extra text from dedupdam file : sed -i "1,62d" ${a1}_dedup.bam


