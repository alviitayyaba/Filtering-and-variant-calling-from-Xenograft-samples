
#!/bin/bash
PICARD="/home/tayyaba/Downloads/picard-2.23.4/picard.jar"

Rgroup_BAM_FOLDER="./Rgroup/*.bam"

OUTPUT_FOLDER_NAME="MarkDup"
mkdir -p ${OUTPUT_FOLDER_NAME}


for file in $Rgroup_BAM_FOLDER
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
        java -jar "${PICARD}" MarkDuplicates --INPUT "$file" --OUTPUT "${OUTPUT_FOLDER_NAME}/${outputFileName}.MarkDup.bam"  --METRICS_FILE "${OUTPUT_FOLDER_NAME}/${outputFileName}.MarkDup.txt"

done
