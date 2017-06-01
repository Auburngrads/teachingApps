##################################################
# this tab is for local deplyment and development
# it allows for an example dataset to be read in
##################################################
uiDataTabItem <- function(config) {
  filterAnalyticDataTable <- fluidRow(box(width=12))
  rawDataTable <- fluidRow(box(width=12))
  if(!config$isRunningInProduction) {
    filterAnalyticDataTable <- fluidRow(box("Filter Analytic Data",width=12,DT::dataTableOutput('filterDataTable')))
    rawDataTable <- fluidRow(box(width=12,DT::dataTableOutput('rawDataTable'),downloadButton('downloadRawDataTable')))
  }
  dataTabItemResult <- tabItem(
    tabName = "Data",
    tabBox(
      width=12,
      tabPanel("Load Data",
        fluidRow(
          box(helpText("Select from the list of available files to read into the analytic.  Please be patient as the calculations
                      are being made.  Once the loading is complete you will see the filter data table populate below.")
          ),
          valueBoxOutput("num_ip")
        ),
        fluidRow(
          box(width=4,uiOutput('dataFiles')),
          actionButton('file_load', "Update Data")
        ),
        (filterAnalyticDataTable)
      ),
      tabPanel("Raw Data",(rawDataTable))
    )
  )
  return (dataTabItemResult)
}


##################################################
# Render raw data table
##################################################
dataRawDataTable <- function(currentValues) {
  rawDataTableResult <- DT::renderDataTable({
      #post entire dataset
      if(length(currentValues$data)>0){
        currentValues$data}
      else{
        df<-as.data.frame(c())
      }
    },
    server=TRUE,
    options=list(
      pageLength=5,
      autoWidth=TRUE,
      scrollX=TRUE
    )
  )
  return (rawDataTableResult)
}


##################################################
# Render filtered data table
##################################################
dataFilterDataTable <- function(currentValues) {
  filterDataTableResult <- DT::renderDataTable({
      #post dataset that will filter entire analytic
      if(length(currentValues$data)>0){
        currentValues$data[,c('Date','sulfate','nitrate')]}
      else{
        df<-as.data.frame(c())
      }
    },
    server=TRUE,
    filter='top',
    options=list(
      pageLength=5,
      autoWidth=TRUE
    )
  )
  return (filterDataTableResult)
}
