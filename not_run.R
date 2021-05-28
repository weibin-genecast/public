list_node <- c("SiteID", "病区",  "癌种", "分期")
data_sankey <- prepdata_sankey(data_patient_info, list_node)
data_sankey

library(plotly)
list <- data_sankey$source
data_sankey$source[is.na(data_sankey$target) == FALSE]
data_sankey$target
data_sankey$value
fig <-  plot_ly(type='sankey',
                orientation='h',
                node = list(
                  label=c("分中心1","分中心2","呼吸内","呼吸外","鳞癌","腺癌","小细胞癌","分期1","分期2","分期3","分期4")
                  ,color=c("#FDE725FF","#B4DE2CFF","#6DCD59FF","#35B779FF","#1F9E89FF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#440154FF","#31688EFF")
                ),
                link = list(
                  source = c(
                    "分中心1",
                    "分中心1",
                    "分中心2",
                    "分中心2",
                    "呼吸内" ,
                    "呼吸内" ,
                    "呼吸内" ,
                    "呼吸外",
                    "呼吸外",
                    "鳞癌",
                    "鳞癌",
                    "鳞癌",
                    "鳞癌",
                    "腺癌",
                    "腺癌",
                    "腺癌",
                    "小细胞癌",
                    "小细胞癌"
                  ),
                  target = c(
                    "呼吸内",
                    "呼吸外",
                    "呼吸内",
                    "呼吸外",
                    "鳞癌" ,
                    "腺癌" ,
                    "小细胞癌",
                    "腺癌" ,
                    "小细胞癌" ,
                    "分期1" ,
                    "分期2",
                    "分期3" ,
                    "分期4"  ,
                    "分期2"  ,
                    "分期3"  ,
                    "分期4" ,
                    "分期1"  ,
                    "分期4"
                  ),
                  value = c(9, 1 , 8, 2, 6 , 7 , 4, 1 , 2 , 1 , 1, 1 , 3, 1, 2 , 5 , 3 , 3)
               
                  # source=c(0,0,1,1,2,2,2,2,3,4,5,5,6,6,6,7),
                  # target=c(2,2,2,3,4,5,6,7,7,8,9,10,8,9,10,10),
                  # value=c(25,5, 48, 22, 1, 30,2,40,27,
                  #         1,12,8,1,4,2,67)
                  # color=c("#FDE725FF","#B4DE2CFF","#6DCD59FF","#35B779FF","#1F9E89FF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#440154FF")
                ))
fig <- fig %>% layout(title='病人流向：分中心->科室->癌种->分期->基因检测')


fig


### success - 1 ####
# find column index into flow
flow <-    c(which(colnames(data_patient_info)=="SiteID"), 
             which(colnames(data_patient_info)=="病区"), 
             which(colnames(data_patient_info)=="癌种"),
             which(colnames(data_patient_info)=="分期"))
# 病人流向：分中心->科室->癌种->分期->基因检测
flow

# check column name
list <- c()
for (i in flow){
  list <- c(list,colnames(data_patient_info[i]))
}
list
### success - 1 ####

### success - 2 ####
#create a data frame with only column required
list_sankey_flow <- c("SiteID", "病区",  "癌种", "分期")
dat1 <- data_patient_info[colnames(data_patient_info) %in% list_sankey_flow == TRUE]
#ncol(dat1)
#dat1
dat1

# add description word in vars -分中心，分期
dat1$SiteID <- sub("^","分中心",dat1$SiteID)
dat1$分期 <- sub("^","分期",dat1$分期) 

# hold for a while ->
# count levels for all source and target
n=0
list <- c()
for(i in 1:ncol(dat1)){
  n <- n+nlevels(as.factor(dat1[,i]))
  list <- c(list,levels(as.factor(dat1[,i])))
}
n
list
dat1
# <- hold for a while

dat <- data.frame()
for (i in 1:ncol(dat1)){
  j=i+1
    temp <- dat1 %>% 
      group_by_(names(.)[i],names(.)[j]) %>% 
      tally() %>% 
      rename(source_name=names(.)[1],target_name=names(.)[2],value=n)
    temp <- as.data.frame(temp)
    dat <- rbind(as.data.frame(dat),as.data.frame(temp))
}
#levels(as.factor(dat$source))
# list2 <- nlevels(as.factor(dat$source))
# list2c <- c(1:nlevels(as.factor(dat$source)))
# list2c
dat <- dat %>% filter(is.na(target_name) == FALSE)
dat
datx <- dat %>% filter(source_name == list[[1]]) %>% mutate(source = 1)
daty <- dat %>% filter(target_name == list[[1]]) %>% mutate(target = 1)
datx
daty

### success - 2 ####

### success -3 ###
# count levels for source
n=0
list <- c()
for(i in 1:ncol(dat1)){
  n <- n+nlevels(as.factor(dat1[,i]))
  list <- c(list,levels(as.factor(dat1[,i])))
}
n
list
### success -3 ###


temp <- dat1 %>% 
  group_by_(names(.)[1],names(.)[2]) %>% 
  summarize(n=n())
  #%>% 
  rename(source=names(.)[1],target=names(.)[2],value=n)
dat <- rbind(dat,temp)

dat1 <- data_patient_info %>% 
  group_by_(names(.)[1],names(.)[3]) %>% 
  summarize(n=n()) %>% 
  rename(source=SiteID,target=病区,value=n)
dat1

dat2 <- data_patient_info %>% 
  group_by(病区,癌种) %>% 
  summarize(n=n()) %>%
  rename(source=病区,target=癌种,value=n)
dat2
dat <- rbind(as.data.frame(dat1),as.data.frame(dat2))
dat

datx <- data_patient_info %>% 
  group_by(癌种,分期) %>% 
  tally()



  summarise(n=n()) %>%
  rename(source3=癌种,target3=分期,value3=n)
datx


label <- c(
  paste0("分中心",levels(as.factor(data_patient_info$SiteID))),
  levels(as.factor(data_patient_info$`病区`)),
  levels(as.factor(data_patient_info$`癌种`)),
  paste0("分期",levels(as.factor(data_patient_info$`分期`)))
)      
label
       
  fig <-  plot_ly(type='sankey',
                  orientation='h',
                  node = list(
                    label=c(),
                    color=c()
                  ),
                  link = list(
                    source=c(),
                    target=c(),
                    value=c(),
                    color=c()
                  ))
  fig <- fig %>% layout(title='病人流向：分中心->科室->癌种->分期')
  
  
  