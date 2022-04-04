#!/bin/bash
GATK='/home/tayyaba/Downloads/gatk-4.1.8.1/gatk-package-4.1.8.1-local.jar'
MarkDup_BAM_FOLDER="./MarkDup/*.bam"


OUTPUT_FOLDER_NAME="Mutect2"
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
  
       java -jar "${GATK}" Mutect2 -R Reference/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -I "$file" --min-base-quality-score 18 --native-pair-hmm-threads 32 --germline-resource  variant-databases/new_gnomeADhg38.vcf --panel-of-normals variant-databases/new_pon.vcf -O   "${OUTPUT_FOLDER_NAME}/${outputFileName}.vcf"

done



