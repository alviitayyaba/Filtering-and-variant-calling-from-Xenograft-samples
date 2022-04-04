#!/bin/bash
GATK='/home/tayyaba/Downloads/gatk-4.1.8.1/gatk-package-4.1.8.1-local.jar'
MarkDup_BAM_FOLDER="./MarkDup/*.bam"

OUTPUT_FOLDER_NAME="BQSR"
mkdir -p ${OUTPUT_FOLDER_NAME}


for file in $MarkDup_BAM_FOLDER
do
        echo "my input is $file"
        IFS='/'
        read -ra tempSlits <<< "$file"
        fileName=${tempSlits[-1]}

        IFS='.bam'
        read -ra fileNameSplits <<< "$fileName"
        tempFileName=${fileNameSplits[0]}
        outputFileName="$tempFileName"

        echo "$outputFileName"
       java -jar "${GATK}"  BaseRecalibrator -R Reference/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -I "$file" --known-sites variant-databases/All-sorted.vcf.gz --known-sites variant-databases/sorted.vcf -O "${OUTPUT_FOLDER_NAME}/${outputFileName}.recal"

       java -jar "${GATK}" ApplyBQSR -R Reference/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -I "$file" -bqsr-recal-file "${OUTPUT_FOLDER_NAME}/${outputFileName}.recal" -O "${OUTPUT_FOLDER_NAME}/${outputFileName}.recal.bam"
       
done
