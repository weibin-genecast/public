############# Value box ###############
denom <- nrow(data_patient_info)
element1 <- data_patient_info %>% filter(data_patient_info$`是否参加临床试验`=="是") %>% count()
output$number1 <- renderText({paste0(element1/denom*100,"%")})

element2 <- data_patient_info %>% filter(data_patient_info$`是否基因检测`=="是") %>% count()
output$number2 <- renderText({paste0(element2/denom*100,"%")})

element3 <- data_patient_info %>% filter(data_patient_info$`手术`=="是") %>% count()
output$number3 <- renderText({paste0(element3/denom*100,"%")})
element4 <- data_patient_info %>% filter(data_patient_info$`靶向治疗`=="是") %>% count()
output$number4 <- renderText({paste0(element4/denom*100,"%")})
element5 <- data_patient_info %>% filter(data_patient_info$`免疫治疗`=="是") %>% count()
output$number5 <- renderText({paste0(element5/denom*100,"%")})
element6 <- data_patient_info %>% filter(data_patient_info$`化疗`=="是") %>% count()
output$number6 <- renderText({paste0(element6/denom*100,"%")})



############# Table ###############
# Filter data based on selections
output$table <- DT::renderDataTable(DT::datatable({
  data <- data_patient_info
  if (input$SID != "All") {
    data <- data[data$SiteID == input$SID,]
  }
  if (input$dep != "All") {
    data <- data[data$`病区` == input$dep,]
  }
  if (input$doc != "All") {
    data <- data[data$`主治医生` == input$doc,]
  }
  data %>% select(list_col_11) %>% arrange(SiteID,PID) %>% rename(患者姓名=姓名,参加临床试验=是否参加临床试验,基因检测=是否基因检测)
}))

############# Pie ###############
output$pie <- renderPlotly({
  library(plotly)
  #donut_data <- data_patient_info %>% group_by(性别) %>% summarize(count=n())
  fig <- plot_ly(textinfo='label+percent',
                 textposition = 'inside',
                 insidetextorientation='radial',
                 showlegend = FALSE)
  
  fig <- fig %>% add_pie(title='病区',
                        hole=0.3,data=count(data_patient_info,病区), labels = ~病区, values = ~n,
                         hoverinfo = 'text',
                         text = ~paste(病区,': ', n ,'人'),
                         domain=list(row=0,column=0)) # pie-1
  
  fig <- fig %>% add_pie(title='性别',
                        hole=0.3,data=count(data_patient_info,性别), labels = ~性别, values = ~n,
                         hoverinfo = 'text',
                         text = ~paste(性别,': ', n ,'人'),
                         domain=list(row=0,column=1)) # pie-2
  
  fig <- fig %>% add_pie(title='癌种',
                         hole=0.3,data=count(data_patient_info,癌种), labels = ~癌种, values = ~n,
                         hoverinfo = 'text',
                         text = ~paste(癌种,': ', n ,'人'),
                         domain=list(row=0,column=2)) # pie-3
  
  fig <- fig %>% add_pie(title='癌症分期',
                         hole=0.3,data=count(data_patient_info,分期), labels = ~分期, values = ~n,
                         hoverinfo = 'text',
                         text = ~paste('分期',分期,': ', n ,'人'),
                         domain=list(row=0,column=3)) # pie-3

  fig <- fig %>% layout(
    # title = 'title',
    grid=list(rows=1, columns=4),
    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  fig
})

# ############# Sankey ###############
output$sankey <- renderPlotly({
  #create a data frame with only column required
  list_node <- c("SiteID", "病区",  "癌种", "分期")
  data_sankey <- prepdata_sankey(data_patient_info,list_node)

    library(plotly)
  data_sankey
  list1 <- c("分中心1","分中心2","呼吸内","呼吸外","鳞癌","腺癌","小细胞癌","分期1","分期2","分期3","分期4")
  list1
  list2 <- as.factor(data_sankey$source)
  list2
  class(list1)
  class(data_sankey$source)

  fig <-  plot_ly(type='sankey',
                  orientation='h',
                  node = list(
                    label=list1
                    ,color=c("#FDE725FF","#B4DE2CFF","#6DCD59FF","#35B779FF","#1F9E89FF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#440154FF","#31688EFF")
                  ),
                  link = list(
                    #source=list2,
                    source=c("0","0","1","1","2","2","2","3","3","4","4","4","4","5","5","5","6","6"),
                    target=c("2","3","2","3","4","5","6","4","6","7","8","9","10","8","9","10","7","10"),
                    value=c(9,1, 8, 2, 6, 7,4,1,2,1,1,1,3,1,2,5,3,3)
                    # source=c(0,0,1,1,2,2,2,2,3,4,5,5,6,6,6,7),
                    # target=c(2,2,2,3,4,5,6,7,7,8,9,10,8,9,10,10),
                    # value=c(25,5, 48, 22, 1, 30,2,40,27,
                    #         1,12,8,1,4,2,67)
                   , color=c("#FDE725FF","#FDE725FF","#B4DE2CFF","#B4DE2CFF","#6DCD59FF","#6DCD59FF","#35B779FF","#35B779FF","#1F9E89FF","#1F9E89FF","#26828EFF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#482878FF","#440154FF","#440154FF")
                  )
                  #, color=c("#FDE725FF","#FDE725FF","#B4DE2CFF","#B4DE2CFF","#6DCD59FF","#6DCD59FF","#35B779FF","#35B779FF","#1F9E89FF","#1F9E89FF","#26828EFF","#26828EFF","#31688EFF","#3E4A89FF","#482878FF","#482878FF","#440154FF","#440154FF")
                  )
  fig <- fig %>% layout(title='病人流向：分中心->科室->癌种->分期->基因检测')

fig
})