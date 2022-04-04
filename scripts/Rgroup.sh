
#!/bin/bash
PICARD="/home/tayyaba/Downloads/picard-2.23.4/picard.jar"

FILTERED_BAM_FOLDER="./Filtered_bams/*.bam"

OUTPUT_FOLDER_NAME="Rgroup"
mkdir -p ${OUTPUT_FOLDER_NAME}


for file in $FILTERED_BAM_FOLDER
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
        java -jar "${PICARD}" AddOrReplaceReadGroups --INPUT "$file" --OUTPUT "${OUTPUT_FOLDER_NAME}/${outputFileName}.rgroup.bam" --SORT_ORDER coordinate --RGID "$fileName" --RGLB "$fileName" --RGPL Illumina --RGPU none --RGSM "$fileName"




done

