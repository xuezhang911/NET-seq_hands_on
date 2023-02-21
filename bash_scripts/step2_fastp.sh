
#!/bin/bash -l
#SBATCH -A snic2022-22-89
#SBATCH -p core
#SBATCH -n 20
#SBATCH -t 72:00:00
#SBATCH -J fastp
#SBATCH --mail-user xue.zhang@slu.se
#SBATCH --mail-type=ALL
module load bioinfo-tools fastp/0.23.2
cd /crex/proj/snic2021-23-14/Xue/NET-seq_nf/raw_fastq
for i in ./*.fastq.gz;
do
echo $i
fname=$(basename ${i/_1.fastq.gz/})
f=${i/_1.fastq.gz/_2.fastq.gz}
echo $fname
echo $f
fastp --in1 $i --in2 $f --out1 ${fname}.trimmed_1.fastp.fastq.gz --out2 ${fname}.trimmed_2.fastp.fastq.gz \
--json ${fname}.trimmed.fastp.json --html ${fname}.trimmed.fastp.html --thread 12 --adapter_sequence_r2=GATCGTCGGACTGTAGAACTCTGAACGTGTAGA \
--umi --umi_loc=per_read --umi_len=4
done