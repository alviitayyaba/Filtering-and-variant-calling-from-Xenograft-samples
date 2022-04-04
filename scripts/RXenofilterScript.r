humanPath <- './xenofilter/bams/human'
humanSamples <- list.files(path= humanPath , pattern = ".bam$" , full.names = TRUE)

mousePath <- './xenofilter/bams/mouse'
mouseSamples <- list.files(path= mousePath , pattern = ".bam$" , full.names = TRUE)

humanSamples <- humanSamples[order(humanSamples)]
mouseSamples <- mouseSamples[order(mouseSamples)]

samples.list <- data.frame(humanSamples,mouseSamples)
bp.param <- SnowParam(workers = 1, type = "SOCK")
## 'SAMPLES.LIST' IS SOMETHING YOU CAN USE IN YOUR 'XenofilteR' FUNCTION

## IF THE USER OF THIS SCRIPT HAS NOT CREATED AN OUTPUTFOLDER, WE CREATE ONE. THIS DOES NOT OVERWRITE IF THE FOLDER ALREADY EXISTS
##dir.create(file.path('./Filtered_bams'), showWarnings = FALSE)
XenofilteR(sample.list = samples.list, destination.folder =
             "xenofilter/", bp.param = bp.param, output.names = NULL, MM_threshold=4, Unmapped_penalty = 8)

## FOLLOWING FOR LOOP CHECKS THE ONE TO ONE CORRESPONDENCE BETWEEN HUMAN AND MOUSE SAMPLES BY MAKING '.txt' FILES 
## AND PUTTING THEM IN A FOLDER WHERE ARGUABLY OUTPUT OF THE TRUE 'XenofilteR' FUNCTION SHOULD BE
for(i in 1:nrow(samples.list)) {
  # print(samples.list[i,'humanSamples'])
  fileNameParts <- unlist(strsplit(samples.list[i,'humanSamples'],'/'))
  fileNameFromHumans <- unlist(strsplit(fileNameParts[length(fileNameParts)],'_HOMO'))[1]
  xenofilterFileName = paste('./Filtered_bams/',fileNameFromHumans,'_Filtered.bam',sep = '')
  fileConn<-file(xenofilterFileName)
  writeLines(c("files having one to one correspondence",samples.list[i,'humanSamples'],samples.list[i,'mouseSamples']), fileConn)
  close(fileConn)
}
