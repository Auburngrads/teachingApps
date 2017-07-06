#' Add the server of one app to the server of another app
#'
#' @description Sources a \code{server.R} file before parsing and evaluating its contents in a specified environment
#'
#' @param app The name of the app from which the content of the \code{server.R} will be pulled
#' @param pkg The package in which \code{app} exists (defaults to \code{teachingApps})
#' @param env The environment in which the call is made typically \code{environment()}
#'
#' @details Currently, this function can be used to insert an \code{server} into
#'          a \code{navbarPage} app.  The types of apps that can be inserted are:
#'          
#'          - \code{fluidPage}
#'          - \code{bootstrapPage}
#'          - \code{pageWithSidebar}
#'          - \code{basicPage}
#'          - \code{fixedPage} 
#'          
#'          A \code{server} can be added as an entire \code{tabPanel} or as a row within 
#'          within a \code{tabPanel} portion of a shiny app. 
#'          
#'          May be used with apps stored in packages other than teachingApps.  
#'          However, apps are assumed be stored in the apps/ directory located 
#'          at top level of the package.
#'  
#' @return An \code{Observer}-class object resulting from evaluating a \code{server.R} file
#' @seealso \code{\link{add_ui}},  \code{\link{add_rmd}}
#' @examples \dontrun{
#' 
#' ## server.R from app: 'maximum_likelihood'
#' 
#' server_ml <- system.file('apps', 
#'                          'maximum_likelihood',
#'                          'server.R',
#'                          package = 'teachingApps') 
#' browseURL(server_ml)
#' 
#' ## server.R from app: 'distribution_weibull'
#' 
#' server_dw <- system.file('apps', 
#'                          'distribution_weibull',
#'                          'server.R',
#'                          package = 'teachingApps') 
#' browseURL(server_dw)
#' 
#' }
#' @export
add_server <- function(app, env = NULL, pkg = 'teachingApps') {
  
  file  <- system.file('apps', app, 'server.R', package = pkg)
  serve <- source(file = file)
  texts <- parse(text = body(serve[[1]])[-1])
  
  eval(texts, envir = env)
}
