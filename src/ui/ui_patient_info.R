tabItem(
  tabName = "patient_info"
  , 
  fluidRow(# fluidRow-1
    # A static valueBox
    # valueBox(value=tags$p(textOutput('number1'),style = "font-size: 100%;"), 
    #          subtitle=tags$p("临床试验",style = "font-size: 100%;")
    #          , width = 6
    #          #,icon = icon("credit-card")
    #          ,color = "light-blue"
    #          ),
    valueBox(""
             ,textOutput('text1')
             #, "患者姓名"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox(""
             ,textOutput('text2')
             #, "年龄"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox(""
             ,textOutput('text3')
             #, "性别"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox("",
             textOutput('text4')
             #, "癌种"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox(""
             ,textOutput('text5')
             #, "分期"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox(""
             ,textOutput('text6')
             #, "随访状态"
             , width = 2
             #,icon = icon("credit-card")
             ,color = "light-blue"
    )
  )# fluidRow-1
  ,
  fluidRow(# fluidRow-2
    box(# box-1
      title = "病程 - Timeline",
      status = "primary",
      solidHeader = TRUE, collapsible = TRUE, collapsed=FALSE,
      width = 12,
      #background = "teal",
      plotlyOutput("timeline")
    )# box-1
  )# fluidRow-2

) # tabItem-1


