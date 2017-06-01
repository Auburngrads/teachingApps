########################################################
# this tab is for operational production and allows for
# reading in of the AFD's from the BDP
########################################################
uiAfdTabItem <- function(config) {
  filterAnalyticDataTable <- fluidRow(box(width=12))
  rawDataTable <- fluidRow(box(width=12))
  if(config$isRunningInProduction) {
    filterAnalyticDataTable <- fluidRow(box("Filter Analytic Data",width=12,DT::dataTableOutput('filterDataTable')))
    rawDataTable <- fluidRow(box(width=12,DT::dataTableOutput('rawDataTable'),downloadButton('downloadRawDataTable')))
  }
  afdTabItemResult <- tabItem(
    tabName = "AFDs",
    tabBox(
      width=12,
      tabPanel("Load Data",
        fluidRow(
          box(
            width=12,
            helpText("This table shows the available Analyst Focused Datasets (AFDs). Select the AFD's you would like to load and press 'Load Data'.  Multiple AFDs may be selected to load into the analytic.  Please be patient as the calculations
                      are being made.  Once the loading is complete you will see the filter data table populate below.  The 'Update Data' button will re-load available AFD's."),
            actionButton('refreshAFDs', "Update Data"),actionButton('afd_load','Load Data')
          ),
          DT::dataTableOutput('afd_table')
        ),
        (filterAnalyticDataTable)
      ),
      tabPanel("Raw Data", (rawDataTable) )
    )
  )
  return (afdTabItemResult)
}


##########################################################
# Give the user a table of available AFDs
##########################################################
afdDataTable <- function(input, currentValues, session) {
  afdDataTableResult <- DT::renderDataTable({
      input$refreshAFDs
      withProgress(message = 'Querying for AFDs', value = 0, {
        currentValues$AFDs <- listAFDs(currentValues$config, session)
      })
      return(currentValues$AFDs)
    },
    server=TRUE,
    options=list(
      pageLength=10,
      order = list(list(5, 'desc')),
      columnDefs = list(list(
        targets = 4,
        render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data.length > 25 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 25) + '...</span>' : data;",
          "}"
        )
      ))
    )
  )
  return (afdDataTable)
}
