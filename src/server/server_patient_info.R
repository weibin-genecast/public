############# Value box ###############
# data_patient_info
# colnames(data_patient_info)

output$text1 <- renderText({paste0("姓名: ",data_patient_info$姓名[[1]])})
output$text2 <- renderText({paste0("年龄: ",data_patient_info$年龄[[1]])})
output$text3 <- renderText({paste0("性别: ",data_patient_info$性别[[1]])})
output$text4 <- renderText({paste0("癌种: ",data_patient_info$癌种[[1]])})
output$text5 <- renderText({paste0("分期: ",data_patient_info$分期[[1]])})
output$text6 <- renderText({paste0("随访状态: ",data_patient_info$随访状态[[1]])})

############# Timeline ###############
output$timeline <- renderPlotly({
  trace_0 <- c(1,NA,NA,NA,NA,NA,NA)
  trace_1 <- c(1.5,1.5,1.5,NA,1.5,1.5,NA)
  trace_2 <- c(NA,1,1,1,NA,NA,NA)
  trace_3 <-  c(NA,NA,NA,1,1,1,1)
  
  month <- c( "2020-01-01", "2020-01-15" ,"2020-02-01" ,"2020-06-05" ,"2020-07-05", "2020-07-09", "2020-09-01")
  
  
  data <- data.frame(month, trace_0, trace_1, trace_2,trace_3)
  
  #The default order will be alphabetized unless specified as below:
  data$month <- factor(data$month, levels = data[["month"]])
  
  a <- list(
    #autotick = FALSE,
    #ticks = "outside",
    #tick0 = 0,
    # dtick = 0.2,
    #ticklen = 5,
    #tickwidth = 2,
    #tickcolor = toRGB("blue")
    ticklabelmode="period",
    ticklabelposition="inside",
    title = "",
    zeroline = TRUE,
    showline = TRUE,
    showticklabels = TRUE,
    showgrid = TRUE
  )
  
  fig3 <- plot_ly(data, x = ~month) 
  fig3 <- fig3 %>% add_trace(y = ~trace_0, name = '手术', type = 'scatter', mode = 'markers+text'
                             , marker = list(size = 15,color = 'red',opacity=1)
                             , text="手术",textposition="top"
                             ,textfont = list(family = "Roboto Condensed", size = 12))
  
  fig3 <- fig3 %>% add_trace(y = ~trace_2, name = '一线治疗', type = 'scatter',mode = 'lines+text'
                             , line = list(width = 20, color = 'light green',opacity=0.5)
                             , text="一线治疗",textposition="center"
                             ,textfont = list(family = "Roboto Condensed", size = 12)) 
  fig3
  fig3 <- fig3 %>% add_trace(y = ~trace_3, name = '二线治疗', type = 'scatter',mode = 'lines'
                             , line = list(width = 20, color = 'blue',opacity=0.5)) 
  fig3 <- fig3 %>% add_trace(y = ~trace_1, name = '辅助治疗', type = 'scatter',mode = 'lines'
                             , line = list(width = 10, color = 'grey',opacity=0.2)) 
  fig3 <- fig3 %>% layout(xaxis=a,yaxis = list(range=c(0,2),zeroline = FALSE,
                                               showline = FALSE
                                               ,showticklabels = FALSE
                                               ,showgrid = FALSE
                                               ,title="y title"
  )
  )
  
  fig3

})
