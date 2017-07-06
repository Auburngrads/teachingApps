#' Nest the server of a smaller app within the server of larger app
#'
#' @description Sources a \code{server.R} file before parsing and evaluating its contents in a specified environment
#'
#' @param app The name of the "smaller" app from which the server will be pulled
#' @param pkg The package in which \code{appName} exists
#' @param env The environment in which the call is made typically \code{environment()}
#'
#' @details This function is only used within a \code{tabPanel} portion of a shiny app.  
#' \code{add_server} may be used with apps stored in other packages.  However, apps are assumed 
#' to be stored in the apps/ directory located at top level of the package.
#'  
#' @return An \code{Observer}-class object resulting from evaluating a \code{server.R} file
#' @seealso \code{\link{add_ui}},  \code{\link{add_rmd}}
#' @examples \dontrun{
#' 
#' ## server.R from teachingApps::maximum_likelihood
#' 
#' server = function(input, output, session) {
#'
#' output$mleback1 <- renderUI({ teachingApps::add_rmd('background1.Rmd') })
#' 
#' output$example1_1 <- renderUI({ teachingApps::add_rmd('example1_1.Rmd') })
#'   teachingApps::add_server('likelihood_ace', envir = environment())
#' output$example1_2 <- renderUI({ teachingApps::add_rmd('example1_2.Rmd') })
#'   teachingApps::add_server('likelihood_ace2', envir = environment())
#' output$example1_3 <- renderUI({ teachingApps::add_rmd('example1_3.Rmd') })
#' 
#' 
#' output$example2_1 <- renderUI({ teachingApps::add_rmd('example2_1.Rmd') })
#'   teachingApps::add_server('exp_mle', envir = environment())
#' output$example2_2 <- renderUI({ teachingApps::add_rmd('example2_2.Rmd') })
#'   teachingApps::add_server('exp_numerical', envir = environment())
#' output$example2_3 <- renderUI({ teachingApps::add_rmd('example2_3.Rmd') })
#'   teachingApps::add_server('soln_numerical2', envir = environment())
#' 
#'   
#' teachingApps:::add_server('likelihood_simulation', envir = environment())
#' 
#' 
#' output$details <- renderUI({ teachingApps::add_rmd('details.Rmd') })
#' }
#' }
#' @export
add_server <- function(app, env = NULL, pkg = 'teachingApps') {
  
  file  <- system.file('apps', app, 'server.R', package = pkg)
  serve <- source(file = file)
  texts <- parse(text = body(serve[[1]])[-1])
  
  eval(texts, envir = env)
}
