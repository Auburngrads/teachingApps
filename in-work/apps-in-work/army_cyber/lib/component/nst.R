########################################################
#
########################################################
uiNstTabItem <- function() {
  nstTabItemResult <- tabItem(
    tabName = "NST",
    valueBoxOutput('NSTBox'),
    box(width=3,uiOutput('NST_Dates')),
    tabBox(
      width=12,
      tabPanel(
        "Plot",
        fluidRow(
          box(width=12,plotlyOutput("NSTPlot"))
        )
      ),
      tabPanel("Data",DT::dataTableOutput('NST_table'))
    )
  )
  return (nstTabItemResult)
}


########################################################
#
########################################################
nstValueBox <- function(currentData) {
  nstValueBoxResult <- renderValueBox({
    count<-NA
    if(length(currentData())>0){
      count<-length(currentData()[,1])
    }
    valueBox(
      formatC("Number of Entries",format='d', big.mark=','), count,
      icon=icon("line-chart"), color='green', width=4
    )
  })
  return (nstValueBoxResult)
}


########################################################
#
########################################################
nstPlotly <- function(input, currentData) {
  nstPlotlyResult <- renderPlotly({
    if(length(currentData())>0) {
      temp<-currentData()[currentData()$Date>input$NST_Dates[1] & currentData()$Date<input$NST_Dates[2],]
      p<-plot_ly(temp, x = Date, y = sulfate, mode = "markers", marker = list(color = "green",size=10))
      p<-add_trace(p, x = Date,y=nitrate, mode= "markers",marker =list(color="blue",size=10)) %>%
      layout(
        title = "Observations By Time",
        xaxis = list(title = ""),
        yaxis = list(title="")
      )
    }
    else{
      #just a place holder to show that no data meets the criteria
      ds <- data.frame(labels = c("No Events", "Seriously No Events"),
                       values = c(50, 50))
      p<-plot_ly(ds, labels = labels, values = values, type = "pie") %>%
        layout(title = "There are no events for this use case!")
    }
  })
  return (nstPlotlyResult)
}


########################################################
#
########################################################
nstDatesUi <- function(currentValues, date1, date2) {
  nstDatesUiResult <- renderUI({
    if(length(currentValues$data)>0){
      dateRangeInput(
        "NST_Dates",
        label="Choose Dates",
        start=date1(),
        end=date2()
      )
    }
    else{
      dateRangeInput(
        "NST_Dates",
        label="Choose Dates",
        start=Sys.time(),
        end=Sys.time()-30
      )
    }
  })
  return (nstDatesUiResult)
}
