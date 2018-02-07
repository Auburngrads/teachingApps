#' Subset data using column values
#'
#' @description Shiny gadget used to visually inspect column values in a data set 
#' and subset rows by specifying column values
#'
#' @param data A data set
#' @param colorBy \code{character} Column by which the \code{parcoords} plot should be colored
#' @param theme \code{character} A bootswatch theme provided to \code{shinythemes::shinytheme}
#' @param width \code{character} Width of the gadget (in valid css units)
#' @param height \code{character} Height of the gadget (in valid css units)
#' @param css \code{character} Path to a custom css file
#' 
#' @import crosstalk
#' @importFrom shinythemes shinytheme
#' @importFrom shiny runGadget browserViewer
#' @importFrom shiny fluidPage tags includeCSS sidebarLayout sidebarPanel
#' @importFrom shiny uiOutput selectizeInput actionButton reactive h4
#' @importFrom shiny stopApp observeEvent mainPanel
#' @importFrom data.table as.data.table
#' @importFrom DT renderDataTable dataTableOutput datatable
#' 
#' @return A \code{list} of length 2
#'   \item{data}{A \code{data.frame} containing the columns that were not removed}
#'   \item{script}{A line of code that can be used to replicate cleaning performed in the gadget}
#' 
#' @examples \dontrun{clean_rows(mtcars)}
#' 
#' @family shinygadgets
#' @return A printed shiny app
#' @export
gadget_clean_rows <- 
function(data, 
         theme = "flatly", 
         colorBy = NULL,
         width = '100%', 
         height = '600px', 
         css = NULL) {
  
pacman::p_load_gh('timelyportfolio/parcoords')

ui = navbarPage(title = 'Data Cleaning App',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = theme),
                header = if(is.null(css)) teachingApps::add_css(),
                
tabPanel(h4('Parcoords'),
         fluidRow( parcoordsOutput('DiamondPlot'))),
tabPanel(h4('Selected Data'),
  sidebarLayout(
    sidebarPanel(width = 3,
                 actionButton('done',h4('Finish'), width = '100%')),
    
    mainPanel(width = 9,
              DT::dataTableOutput('SelectedData')))))

server = function(input, output) {
  
  output$DiamondPlot <- renderParcoords({
    parcoords(data,
              rownames= T,
              color = list(colorScale = htmlwidgets::JS('d3.scale.category10()'),
                            colorBy = colorBy),
              autoresize = T,
              reorderable = T,
              width = NULL,
              height = 800,
              brushMode = "1D")
  })
  ###Here we can access the variable input$id_rows to determine which are selected
  ###we display these results in a table
  
  ids <- reactive({ rownames(data) %in% input$DiamondPlot_brushed_row_names })
  
output$SelectedData <- DT::renderDataTable({
    
    DT::datatable(data[ids(),])
  
})
observeEvent(input$done, { 
    
    stopApp(list(data = as.data.frame( data[ids(),] )))
})
}
              runGadget(app = ui,
                        server = server,
                        viewer = browserViewer(browser = getOption("browser")))
}