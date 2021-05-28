#############################################
### sankey flow data preparation function ###
#############################################

# library(tidyverse)
# list_node <- c("SiteID", "病区",  "癌种", "分期")
# load_data_patient_info <- read.csv(paste0(wd_path,"/data/patient_info.csv"),header=TRUE,skip=1)
# data_patient_info <- load_data_patient_info %>% filter(is.na(load_data_patient_info$PID) == FALSE)
# prepdata_sankey(data_patient_info,list_node)

###### function ############
prepdata_sankey <- function(data, list_node){# function
  # create data frame with only nodes in flow needed
dat1 <- data[colnames(data) %in% list_node == TRUE]

# add description word in vars -分中心，分期
dat1$SiteID <- sub("^","分中心",dat1$SiteID)
dat1$分期 <- sub("^","分期",dat1$分期) 


dat <- data.frame()
for (i in 1:ncol(dat1)){
  j=i+1
  temp <- dat1 %>% 
    group_by_(names(.)[i],names(.)[j]) %>% 
    tally() %>% 
    rename(source_name=names(.)[1],target_name=names(.)[2],value=n)
  temp <- as.data.frame(temp)
  dat <- rbind(as.data.frame(dat),as.data.frame(temp))
} # for loop

dat <- dat %>% filter(is.na(target_name) == FALSE)
dat

}# function
