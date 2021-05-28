shinyServer(function(input, output) {
    #source("./src/server/server_patient_info.R", local=TRUE, encoding="UTF-8")$value 
    source("./src/server/server_patient_management.R", local=TRUE, encoding="UTF-8")$value 
    source("./src/server/server_patient_info.R", local=TRUE, encoding="UTF-8")$value 
    
    # output$messageMenu <- renderMenu({
    #     # Code to generate each of the messageItems here, in a list. This assumes
    #     # that messageData is a data frame with two columns, 'from' and 'message'.
    #     msgs <- apply(messageData, 1, function(row) {
    #         messageItem(from = row[["from"]], message = row[["message"]],time = Sys.Date())
    #     })
    #     
    #     # This is equivalent to calling:
    #     #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
    #     dropdownMenu(type = "messages", .list = msgs)
    # })
    
})
