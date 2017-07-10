
###############SERVER SIDE BUILD#############
server <- function(input, output, session) {

  #Create a local variable that will cause reactive events
  currentValues <- reactiveValues()
  currentValues$config <- config

#######Populate Sidebar Menu######
  output$menuSidebar<-renderMenu({
    if(length(currentValues$data)>0){
      uiActionSidebarMenu(config)
      #sidebarMenu(
      #  #comment out next line for operational deployment
      #  menuItem("Load Data Files",tabName="Data",icon=icon("file")),
      #  #uncomment for operational deployment
      #  #menuItem("Load-Filter-Explore", tabName = "AFDs", icon = icon("database")),
      #  menuItem("New Tab", tabName = "NT", icon = icon("dashboard"),
      #           menuSubItem('New Sub Tab', tabName = 'NST', icon = icon('dashboard'))
      #  ),
      #  menuItem("Take Action",tabName="ACT",icon=icon('rocket'))
      #)
    }
    else{
      uiNonActionSidebarMenu(config)
      #sidebarMenu(
      #  #comment out next line for operational deployment
      #  menuItem("Load Data Files",tabName="Data",icon=icon("file"))
      #  #uncomment for operational deployment
      #  #menuItem("Load-Filter-Explore", tabName = "AFDs", icon = icon("database"))
      #)
    }
  })
  isolate({updateTabItems(session, "tabs", "Tool")})


#####read in data from file list#########
  # populate the list of filenames in the data read tab
  # This is done in the server block to ensure that different users/sessions will have appropriately different available data sets.
  output$dataFiles <-
    renderUI({
      input$refreshList
      dataSets <- list.files('data')
      selectInput("dataFiles", 'Select data files', choices = dataSets , multiple=TRUE, selectize=FALSE)
    })

  observeEvent(input$file_load,{
    currentValues$isAfd <- FALSE

    tryCatch({
      currentValues$data <- loadData(input$dataFiles, currentValues, session)
      updateValues(currentValues)
      currentValues$loadedDataSets <- input$dataFiles
    }, warning = function(w) {
      print(paste("loadFiles warning: ",w))
      clearData(currentValues)
    }, error = function(e) {
      print(paste("loadFiles error: ",e))
      clearData(currentValues)
    }, finally = {
    })
  })


#####AFD TABLE tab######
  output$afd_table <- afdDataTable(input, currentValues, session)

  # Load data when the AFD rows are selected
  observeEvent(input$afd_load, {
    selected <- input$afd_table_rows_selected
    if (length(selected)) {
      afds <- currentValues$AFDs
      afdIds <- laply(selected, function(id) {afds[as.numeric(id),]$id})

      currentValues$isAfd <- TRUE

      tryCatch({
        currentValues$data <- loadData(afdIds, currentValues, session)
        updateValues(currentValues)
        currentValues$loadedDataSets <- afdIds
      }, warning = function(w) {
        logger.log(paste("loadFiles warning: ",w))
        clearData(currentValues)
      }, error = function(e) {
        logger.log(paste("loadFiles error: ",e))
        clearData(currentValues)
      }, finally = {
      })
    }
  })

  #render ARCYBER logo
  output$image <- renderImage({
    return(list(
      src = "www/ACC.png",
      contentType = "image/png",
      width = '100%',
      height = '100%'
    ))
  },deleteFile = FALSE)

  #This function will create an updated currentData object to be passed to all other functions
  #The currentValues object is a list and the currentData object is a data frame
  #This function should be repeated for every dataframe in the currentValues object
  #Important!!! must change the term 'data' to the name of the data frame in the list!!

  currentData<-reactive({
    currentData <- currentValues$data[input$filterDataTable_rows_all,]
  })

  #use these reactive dates to build left and right limit of plots
  date1<-reactive({min(currentData()$Date)})
  date2<-reactive({max(currentData()$Date)})


  ######NST Example Tab Content#######
  output$NSTBox <- nstValueBox(currentData)
  output$NSTPlot <- nstPlotly(input, currentData)
  output$NST_Dates <- nstDatesUi(currentValues, date1, date2)


  ######Take Action tab######

  output$actionTable = DT::renderDataTable(currentValues$action, filter='top',options=list(autoWidth=TRUE))

  #create a proxy table to prevent from being rendered multiple times
  proxy = dataTableProxy('actionTable')

  #move from action to cleared or deconflict and remove from action
  observeEvent(input$Update,{
    s = input$actionTable_rows_selected
    for(i in 1:length(s)){
      currentValues$action$action_req[as.numeric(s[i])]<-input$ActionReq
      currentValues$action$behavior_type[as.numeric(s[i])]<-input$Type
    }
  })

  observeEvent(input$selectAll, {
    selectRows(proxy, as.numeric(input$actionTable_rows_all))
  })

  observeEvent(input$clear, {
    selectRows(proxy, NULL)
  })

  #download action report
  output$downloadReport <- downloadActionReport(input, currentValues, date1, date2)


  ##DATA TABLEs##
  output$rawDataTable <- dataRawDataTable(currentValues)
  output$filterDataTable <- dataFilterDataTable(currentValues)

  #download country data table
  output$downloadRawDataTable <- downloadHandler(
    filename = function() {
      paste('Raw_Data_', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
      write.csv(currentData(), file)
    }
  )

}
