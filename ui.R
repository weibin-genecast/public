shinyUI( 
    #     navbarPage("Dashboard Gallery",
    #      tabPanel("Design 1") # tabPanel-1
    #       ,
    #      tabPanel("Design 2") # tabPanel-2
    #       ) # navbarPage
    
    source("./src/dash/dash_design_1.R", local=TRUE, encoding="UTF-8")$value
) # shinyUI
