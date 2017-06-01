###############SERVER SIDE BUILD#############
server <- function(input, output, session) {

  #render logo
output$image <- renderImage({
    return(list(src = "www/Data-Science-Lab.png",
                contentType = "image/png"))
    },deleteFile = FALSE)
  
currentData <- reactive({
    as.data.frame(readr::read_csv(input$dataFiles$datapath))
  })

observeEvent(input$refreshList,{
             updateSelectizeInput(session,
                                  "variables",
                                  label = "Select variables to investigate",
                                  choices = colnames(currentData()))
             num_rows = as.numeric(nrow(currentData()))
             updateSelectInput(session,
                               "block.levels",
                               label = "Select a block size",
                               choices = unlist(get_all_factors(num_rows),use.names = F))
})


  ##DATA TABLE tab##
  #give the user a data table to explore
output$original.table <-DT::renderDataTable({

   DT::datatable(currentData(),
                 options = list(pageLength = 10, 
                                scrollX = TRUE))
  })

  # State_Vector = reactive({})

  State.Vector <- eventReactive(input$go,{
    
    block_size = as.numeric(input$block.levels)
    temp = as.data.frame(currentData()[,c(input$variables)])
    charc_vars = which(lapply(temp, class) == "character",arr.ind = TRUE)
    temp[,charc_vars] = lapply(temp[,charc_vars],as.factor)
    idx = colnames(dplyr::select(temp,contains("port")))
    temp[idx] = lapply(temp[idx],as.factor)
    reducedData = as.data.frame(temp)
    colnames(reducedData) <- colnames(currentData()[,c(input$variables)])
    TVA2(reducedData,block_size,50,10)
  })


output$SV.table <- DT::renderDataTable({
  
    DT::datatable(State.Vector(),
                  options = list(pageLength = 10, scrollX = TRUE))
})



}
