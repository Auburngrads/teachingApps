#' Nest the server of a smaller app within the server of larger app
#'
#' @description Sources a \code{server.R} file before parsing and evaluating its contents in a specified environment
#'
#' @param appName The name of the "smaller" app from which the server will be pulled
#' @param pkg The package in which \code{appName} exists
#' @param envir The environment in which the call is made typically \code{environment()}
#'
#' @details This function is only used within a \code{tabPanel} portion of a shiny app.  
#' \code{nestServer} may be used with apps stored in other packages.  However, apps are assumed 
#' to be stored in the apps/ directory located at top level of the package.
#'  
#' @return An \code{Observer}-class object resulting from evaluating a \code{server.R} file
#' @seealso \code{\link{nestUI} \link{nestRmd}}
#' @examples \dontrun{
#' 
#' ## server.R from teachingApps::maximum_likelihood
#' 
#' server = function(input, output, session) {
#'
#' output$mleback1 <- renderUI({ teachingApps::nestRmd('background1.Rmd') })
#' 
#' output$example1_1 <- renderUI({ teachingApps::nestRmd('example1_1.Rmd') })
#'   teachingApps::nestServer('likelihood_ace', envir = environment())
#' output$example1_2 <- renderUI({ teachingApps::nestRmd('example1_2.Rmd') })
#'   teachingApps::nestServer('likelihood_ace2', envir = environment())
#' output$example1_3 <- renderUI({ teachingApps::nestRmd('example1_3.Rmd') })
#' 
#' 
#' output$example2_1 <- renderUI({ teachingApps::nestRmd('example2_1.Rmd') })
#'   teachingApps::nestServer('exp_mle', envir = environment())
#' output$example2_2 <- renderUI({ teachingApps::nestRmd('example2_2.Rmd') })
#'   teachingApps::nestServer('exp_numerical', envir = environment())
#' output$example2_3 <- renderUI({ teachingApps::nestRmd('example2_3.Rmd') })
#'   teachingApps::nestServer('soln_numerical2', envir = environment())
#' 
#'   
#' teachingApps:::nestServer('likelihood_simulation', envir = environment())
#' 
#' 
#' output$details <- renderUI({ teachingApps::nestRmd('details.Rmd') })
#' }
#' }
#' @export

nestServer <- function(appName, envir = NULL, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'server.R', package = pkg)
  serve <- source(file = file)
  texts <- parse(text = body(serve[[1]])[-1])
  
  eval(texts, envir = envir)
}


#' Nest the UI of smaller app within the UI of a larger app
#' 
#' @description Sources a \code{ui.R} file before parsing and evaluating its contents in a specified environment
#' 
#' @param appName The name of "smaller" app from which the UI will be pulled
#' @param pkg The package in which \code{appName} exists
#' 
#' @details This function should only be used within a \code{tabPanel} portion of a shiny app.  
#' \code{nestServer} may be used with apps stored in other packages.  However, apps are assumed 
#' to be stored in the apps/ directory located at top level of the package.
#' 
#' @seealso \code{\link{nestServer} \link{nestRmd}} 
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
#'          fluidRow(teachingApps::nestUI('likelihood_ace')),
#'          fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::nestUI('likelihood_ace2')),
#'          fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),
#' 
#' tabPanel(h4('Silly Example'),
#'          fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::nestUI('exp_mle')),
#'          fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::nestUI('exp_numerical')),
#'          fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
#'          fluidRow(teachingApps::nestUI('soln_numerical2'))),
#' 
#' tabPanel(h4("A Simulation"),
#'          fluidRow(teachingApps:::nestUI('likelihood_simulation'))),
#' 
#' tabPanel(h4('Details'),
#'          fluidRow(uiOutput('details'), class = 'shiny-text-output')))
#' 
#' }
#' @export

nestUI <- function(appName, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'ui.R', package = pkg)
  serve <- source(file = file)
  
  return(serve[[1]])
  
}

#' Nest an rmarkdown file within an app
#' 
#' @description Run inline and stand-alone code chunks and include results
#' as part of a shiny app. Include \code{LaTeX}-typeset equations with MathJax
#' 
#' @importFrom shiny getShinyOption withMathJax HTML
#' @importFrom knitr knit
#' @importFrom markdown markdownToHTML 
#' 
#' @param rmd An rmarkdown file saved in the app directory
#' 
#' @seealso \code{\link{nestServer} \link{nestUI}}
#' 
#' @examples \dontrun{# see examples in nestServer and nestUI documentation}
#' @export

nestRmd <- function(rmd) {
  
  rmd <- paste(c(getShinyOption('appDir'),rmd), collapse = '/')
   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(rmd))))
  
}

