#' Nests the UI of smaller app within the UI of a larger app
#' 
#' @description Sources a \code{ui.R} file before parsing and evaluating its contents in a specified environment
#' 
#' @param appName The name of "smaller" app from which the UI will be pulled
#' @param pkg The package in which \code{appName} exists
#' 
#' @details This function should only be used within a \code{tabPanel} portion of a shiny app.  
#' \code{add_Server} may be used with apps stored in other packages.  However, apps are assumed 
#' to be stored in the apps/ directory located at top level of the package.
#' 
#' @seealso \code{\link{add_server} \link{add_rmd}} 
#' @return A list of length 2
#' \item{head}{A sub list containing the HTML content within the \code{<head>} tag}
#' \item{body}{A sub list containing the HTML content within the \code{<body>} tag}
#'
#' @examples \dontrun{
#' 
#' ## ui.R from teachingApps::maximum_likelihood
#' 
#' library(teachingApps)
#' library('scales')
#' library(knitr)
#'          
#' ui = navbarPage(title = 'Maximum Likelihood',
#'                 collapsible = T, 
#'                 position = 'fixed-top',
#'                 theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
#'                 header = tags$head(includeCSS(getShinyOption("css"))),
#'                 footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
#' 
#' tabPanel(h4('Background'),
#'          fluidRow(uiOutput('mleback1'), class = 'shiny-text-output')),
#' 
#' tabPanel(h4('Simple Example'),  
#'          fluidRow(uiOutput('example1_1'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::add_ui('likelihood_ace')),
#'          fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::add_ui('likelihood_ace2')),
#'          fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),
#' 
#' tabPanel(h4('Silly Example'),
#'          fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::add_ui('exp_mle')),
#'          fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::add_ui('exp_numerical')),
#'          fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::add_ui('soln_numerical2'))),
#' 
#' tabPanel(h4("A Simulation"),
#'          fluidRow(teachingApps:::add_ui('likelihood_simulation'))),
#' 
#' tabPanel(h4('Details'),
#'          fluidRow(uiOutput('details'), class = 'shiny-text-output')))
#' 
#' }
#' @export
add_ui <- function(appName, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'ui.R', package = pkg)
  serve <- source(file = file)
  
  return(serve[[1]])
  
}
