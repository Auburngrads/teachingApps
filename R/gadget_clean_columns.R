#' Visually remove columns from data set
#'
#' @description Shiny gadget used to visually inspect columns in a data set and select columns to remove
#'
#' @param data A data set
#' @param rownames \code{logical} Should rownames be included?
#' @param theme \code{character} A bootswatch theme provided to \code{shinythemes::shinytheme}
#' @param width \code{character} Width of the gadget (in valid css units)
#' @param height \code{character} Height of the gadget (in valid css units)
#' @param css \code{character} Path to a custom css file
#' 
#' @importFrom shinythemes shinytheme
#' @importFrom shiny runGadget browserViewer
#' @importFrom shiny fluidPage tags includeCSS sidebarLayout sidebarPanel
#' @importFrom shiny uiOutput selectizeInput actionButton reactive h4
#' @importFrom shiny stopApp observeEvent mainPanel fluidRow
#' @importFrom data.table as.data.table ':='
#' @importFrom DT renderDataTable dataTableOutput datatable
#' 
#' @return A \code{list} of length 2
#'   \item{data}{A \code{data.frame} containing the columns that were not removed}
#'   \item{script}{A line of code that can be used to replicate cleaning performed in the gadget}
#' 
#' @examples \dontrun{clean_columns(mtcars)}
#' 
#' @family shinygadgets
#' @return A printed shiny app
#' @export
gadget_clean_columns <- 
function(data, 
         rownames = TRUE, 
         theme = "flatly",
         width = '100%', 
         height = '600px', 
         css = NULL) {

pacman::p_load(shiny, data.table)

ui = fluidPage(theme = shinythemes::shinytheme(theme = theme),
               if(is.null(css)) teachingApps::add_css(),
               
sidebarLayout(
  sidebarPanel(width = 3,
    uiOutput("names"),
    actionButton('done',h4('Finish'), width = '100%')), 
  
    mainPanel(width = 9,
              DT::dataTableOutput("cleandata", height = "600px"))))
server = function(input, output) {
output$names <- renderUI({
  
  selectizeInput('remove', 
                 h4('Columns To Remove'),
                 choices = colnames(data),
                 selected = NULL, 
                 multiple = TRUE)
})

clean.data <- reactive({ 
  
       `if`(is.null(input$remove),
            as.data.table(data, keep.rownames = rownames),
            as.data.table(data, keep.rownames = rownames)[,as.character(input$remove):= NULL]) })
  output$cleandata <- DT::renderDataTable({
    
      DT::datatable(clean.data(),
                    fillContainer = T,
                    extensions = 'Responsive',
                    rownames = rownames)
    
})
  observeEvent(input$done, { 
    
    colnums = lapply(X = input$remove,
                     FUN = function(x) { which(colnames(data)==x)})
    
    paste1 <- paste(c(unlist(colnums)), collapse = ',')
    paste2 <- parse(text = paste(c('c(',paste1,')'), collapse = ''))
    script <- paste(c('data[, -',paste2[[1]],']'), collapse = '')
    
    stopApp(list(data = as.data.frame( clean.data() ),
                 script = parse(text = script)[[1]]))
    
})
}
              runGadget(app = ui,
                        server = server,
                        viewer = browserViewer(browser = getOption("browser")))
}
