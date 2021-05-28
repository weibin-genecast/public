#################################### HEADER ####################################
# Create app on 2021/5/27 by Bin Wei
##################################### CODE #####################################
install.packages(shiny)
install.packages(shinydashboard)
install.packages(shinydashboardPlus)
install.packages(plotly)
install.packages(ggplot2)
install.packages(tidyverse)
install.packages(DT)
install.packages(networkD3)

library(shiny)
library(shinydashboard)
library(shinydashboardPlus) # for more shiny setting
library(plotly)
library(ggplot2)
library(tidyverse) # for pipe
library(DT) # for Table
library(networkD3) # for sankey plot

### Packages loading -----------------------------------------------------------
suppressPackageStartupMessages({
  library(shiny)
  library(shinydashboard)
  library(shinydashboardPlus) # for more shiny setting
  library(plotly)
  library(ggplot2)
  library(tidyverse) # for pipe
  library(DT) # for Table
  library(networkD3) # for sankey plot
})

### work direction -------------------------------------------------------------
wd_path <- getwd()

### Load Functions --------------------------------------------------------------
source("./src/fun/fun_sankey_prepdata.R",local = TRUE, encoding = "UTF-8")

### Load data --------------------------------------------------------------
# source("./data/data_v1.R",local = TRUE, encoding = "UTF-8")

load_data_patient_info <- read.csv(paste0(wd_path,"/data/patient_info.csv"),header=TRUE,skip=1)
data_patient_info <- load_data_patient_info %>% filter(is.na(load_data_patient_info$PID) == FALSE)
list_col_11 <- c("SiteID","PID","病区","主治医生","姓名","性别","年龄","联系电话","医疗支付方式","是否参加临床试验","是否基因检测")

