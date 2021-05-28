tabItem(
  tabName = "patient_management"
  , 
  fluidRow(# fluidRow-1
    # A static valueBox
    # valueBox(value=tags$p(textOutput('number1'),style = "font-size: 100%;"), 
    #          subtitle=tags$p("临床试验",style = "font-size: 100%;")
    #          , width = 6
    #          #,icon = icon("credit-card")
    #          ,color = "light-blue"
    #          ),
    valueBox(textOutput('number1'), "临床试验", width = 6
             #,icon = icon("credit-card")
             ,color = "light-blue"
    ),
    valueBox(textOutput('number2'), "基因检测", width = 6
             #,icon = icon("credit-card")
             ,color = "light-blue"
             ),
    valueBox(textOutput('number3'), "手术", width = 3
             #,icon = icon("credit-card")
             ,color = "maroon"
             ),
    valueBox(textOutput('number4'), "靶向治疗", width = 3
             #,icon = icon("credit-card")
             ,color = "olive"
             ),
    valueBox(textOutput('number5'), "免疫治疗", width = 3
             #,icon = icon("credit-card")
             ,color = "purple"
             ),
    valueBox(textOutput('number6'), "化疗", width = 3
             #,icon = icon("credit-card")
             ,color = "orange"
             )
  )# fluidRow-1
    ,
fluidRow(# fluidRow-3
    box(# box-1
      title = "病人流向 - Sankey plot",
      status = "primary",
      solidHeader = TRUE, collapsible = TRUE, collapsed=TRUE,
      width = 12,
      #background = "teal",
      plotlyOutput("sankey")
    )# box-1
    ,
    box(# box-2
      title = "各分组比例 - Donut plot",
      status = "primary", 
      solidHeader = TRUE, collapsible = TRUE, collapsed=TRUE,
      width = 12,
      #background = "teal",
      plotlyOutput("pie")
      )# box-2
  )# fluidRow-3
  ,
  fluidRow(# fluidRow-4
    column(4,
           selectInput("SID",
                       "Site ID:",
                       c("All",
                         unique(as.character(data_patient_info$SiteID))))
    ),
    column(4,
           selectInput("dep",
                       "病区:",
                       c("All",
                         unique(as.character(data_patient_info$`病区`))))
    )
    ,
    column(4,
           selectInput("doc",
                       "主治医生:",
                       c("All",
                         unique(as.character(data_patient_info$`主治医生`))))
    )
    
  )# fluidRow-4
  ,
  # Create a new row for the table.
  DT::dataTableOutput("table")
  
  
) # tabItem-1
