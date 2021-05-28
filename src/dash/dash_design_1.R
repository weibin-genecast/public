dashboardPage(title = "OncoJourney Version 1.0", 
              #options = list(sidebarExpandOnHover = TURE),
              #skin = "black",
              
              ### Header
              dashboardHeader(title = "OncoJourney",
                              dropdownMenu(
                                type = "messages",
                                notificationItem(text = "数据库新增2个病人",
                                                 icon("users")),
                                notificationItem(text = "收到3个基因检测报告",
                                                 icon("truck"),
                                                 status = "success")
                              ) # dropdownMenu-1
                              
              ) # dashboardHeader
              ,
              ### side bar
              dashboardSidebar(
                minified = TRUE, collapsed = FALSE,
                sidebarMenu(
                  menuItem("病人管理", tabName="patient_management",
                           badgeLabel = "new",
                           badgeColor = "green",
                           icon = icon("dashboard")
                           # ,
                           # menuSubItem("相关性分析", tabName = "correlation",icon = icon("chart-bar")),
                           # menuSubItem("生存分析", tabName = "survival",icon = icon("chart-line"))
                           ),
                  menuItem("病人信息", tabName="patient_info",
                           badgeLabel = "new",
                           badgeColor = "green",
                           icon = icon("address-card")),
                  menuItem("病史",
                           tabName = "patient_pathway",
                           icon = icon("notes-medical")), 
                  menuItem(
                    "住院记录",
                    tabName = "hospitalization",
                    icon = icon("hospital"),
                    menuSubItem("手术记录", tabName = "operation",icon = icon("file-prescription")),
                    menuSubItem("护理记录 ", tabName = "nursing",icon = icon("procedures"))
                  ), 
                  menuItem("基因检测报告",
                           tabName = "gene_report",
                           icon = icon("dna")), 
                  menuItem("访问臻和", icon = icon("ad"),
                           href = "http://www.genecast.com.cn/")
                ) # sidebarMenu
                
              ) # dashboardSidebar
              ,
              ### body
              dashboardBody(
                tags$head(tags$style(HTML('
                                /* logo */
                                .skin-blue .main-header .logo {
                                background-color: #6E006C;
                                }
                                /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #006884;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #91278F;
                              } '
        #  /* infobox */
        # .small-box {height: 150px; line-height: 150px;}
        # .small-content {padding-top: 0px; padding-bottom: 0px;}'
                                          ))) # tags$head
                ,
                tabItems(
                  source("./src/ui/ui_patient_management.R", local = TRUE, encoding = "UTF-8")$value,
                  source("./src/ui/ui_patient_info.R", local = TRUE, encoding = "UTF-8")$value
                  
                )# tabItems
              ) # dashboardBody
              ,
              ### Control bar
              dashboardControlbar()# dashboardControl bar
              
) # dashboardPage