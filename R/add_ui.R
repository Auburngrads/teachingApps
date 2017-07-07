#' Add the UI of one app within the UI of another app
#' 
#' @description Sources a \code{ui.R} file before parsing and evaluating its contents in a specified environment
#' 
#' @param app The name of the app from which the content of the \code{server.R} will be pulled
#' @param pkg The package in which \code{app} exists (defaults to \code{teachingApps})
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
add_ui <- function(app, pkg = 'teachingApps') {
  
  file  <- system.file('apps', app, 'ui.R', package = pkg)
  serve <- source(file = file)
  
  return(serve[[1]])
  
}
