#' Add the UI of one app within the UI of another app
#' 
#' @description Sources a \code{ui.R} file before parsing and evaluating its contents in a specified environment
#' 
#' @param app  Name of the app from which the content of the \code{ui.R} will be pulled
#' @param path Path to a directory containing the app from which the content of the \code{ui.R} will be pulled
#'
#' @importFrom shiny addResourcePath
#'
#' @details Currently, this function can be used to insert an \code{server} into
#'          a \code{navbarPage} app.  The types of apps that can be inserted are:
#'      \itemize{
#'          \item{\code{fluidPage}}{}
#'          \item{\code{bootstrapPage}}{}
#'          \item{\code{pageWithSidebar}}{}
#'          \item{\code{basicPage}}{}
#'          \item{\code{fixedPage}}{}
#'       }
#'          
#'          A \code{server} can be added as an entire \code{tabPanel} or as a row within 
#'          within a \code{tabPanel} portion of a shiny app. 
#'          
#'          May be used with apps stored in packages other than teachingApps.  
#'          However, apps are assumed be stored in the \code{apps/} directory located 
#'          at top level of the package.
#'  
#' @seealso \code{\link{add_server}} \code{\link{add_rmd}} 
#' @return A list of length 2
#' \item{head}{A sub list containing the HTML content within the \code{<head>} tag}
#' \item{body}{A sub list containing the HTML content within the \code{<body>} tag}
#'
#' 
#' @examples \dontrun{
#' 
#' ## ui.R from app: 'maximum_likelihood'
#' 
#' ui_ml <- system.file('apps', 
#'                      'maximum_likelihood',
#'                      'server.R',
#'                      package = 'teachingApps') 
#' browseURL(ui_ml)
#' 
#' ## ui.R from app: 'distribution_weibull'
#' 
#' ui_dw <- system.file('apps', 
#'                      'distribution_weibull',
#'                      'server.R',
#'                      package = 'teachingApps') 
#' browseURL(ui_dw)
#' 
#' }
#' @export
add_ui <- function(app, path) {
  
  no_app  <- missing(app)  || is.null(app)  || is.na(app)
  no_path <- missing(path) || is.null(path) || is.na(path)
  
  if( no_app &&  no_path) stop('Either an app or a path must be specified')
  if(!no_app && !no_path) stop('Only one app or path should be specified')

  if(no_path) {
    
     file <- system.file('apps', app, 'ui.R', package = 'teachingApps')
     
     } else {
    
     shiny::addResourcePath(basename(path), path)
     file <- file.path(path, 'ui.R')
       
     }
  
  ui <- source(file = file)
  
  return(ui[[1]])
  
}
