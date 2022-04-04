
#!/bin/bash

for f in `ls *.fq.gz | cut -f 1 -d'_'`
do
bwa mem -t 16 Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa ${f}_1.fq.gz ${f}_2.fq.gz | samtools view -Sb - | samtools sort -@ 16 -o ${f}-homo.bam
done


