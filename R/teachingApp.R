#' Render a teachingApp With Options
#'
#' @description Renders a teachingApp as a stand-alone app
#'     or as an element within an rmarkdown document. 
#'
#' @importFrom shinythemes shinytheme
#' @importFrom shinyAce aceEditor
#' @importFrom utils View
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout renderUI titlePanel
#' @importFrom shiny brushedPoints brushOpts br hr checkboxInput div
#' @importFrom shiny fixedPanel uiOutput HTML htmlOutput sidebarLayout tags renderUI 
#' @importFrom shiny sidebarPanel mainPanel fluidPage navbarPage tabPanel h2 h4
#' @importFrom shiny tabsetPanel withMathJax updateSelectInput updateSliderInput
#' @importFrom shiny updateNumericInput strong stopApp shinyAppDir
#' @importFrom shiny radioButtons clickOpts runApp helpText h1 h5 h6 includeCSS
#' @importFrom shiny includeScript includeMarkdown inputPanel isolate nearPoints
#' @importFrom shiny observe observeEvent reactiveValues reactive renderText selectInput
#' @importFrom shiny actionButton selectizeInput plotOutput renderPlot fillRow fillCol
#'
#' @param app_name \code{character} Name of the app to be rendered
#' @param theme \code{character} Name of a bootswatch color theme (provided by \code{shinythemes::shinytheme})
#' @param width \code{character} The width of the printed app (in pixels)
#' @param height \code{character} The height of the printed app (in pixels)
#' @param icon  \code{character} A fontAwesome icon to be placed in the footer of a navbarPage app
#' @param img \code{character} A path (or URL) to an image to be placed in the footer of a navbarPage app
#' @param git_user \code{character} GitHub username used in the branding logo
#' @param more_opts A \code{list} of additional options/objects that can be passed to the app (see Details)
#' @param ... A \code{list} of additional options passed to \code{shiny::shinyAppDir()} 
#' 
#' @return A printed shiny app
#' @export
#' @details The \code{teachingApps} package provides an infrastructure 
#'    that allows users to dynamically change the appearance and function of
#'    shiny apps. R users a familiar with writing functions to dynamically alter 
#'    some output - in this case the output is a app.  Normally, 
#'
#' @seealso code{link{create_logo}}
#' @seealso code{link{add_logo}}
#' @examples 
#' \dontrun{
#' teachingApps(app_name = 'distribution_goma', 
#'              theme = 'spacelab', 
#'              height = '800px',
#'              git_user = 'Auburngrads')
#' 
#' teachingApps(app_name = 'maximum_likelihood_simulation',
#'              git_user = 'Auburngrads')
#' }
teachingApp <- 
function(app_name = NULL, 
         theme = 'flatly',
         width = '100%',
         height = '800px',
         icon = 'fa fa-github',
         img = NULL,
         git_user = 'Auburngrads',
         more_opts = list(NA),...)
{
 
    valid_apps <- list.files(system.file("apps", package = "teachingApps"))

    valid_apps_df <- data.frame(valid_apps)
    colnames(valid_apps_df) <- 'Valid teachingApps'
    
    if (missing(app_name) || !nzchar(app_name) || !app_name %in% valid_apps) {
      
    stop(paste0('Please run `teachingApp()` with a valid app as an argument.\n',
                 "See table for Valid teachingApps"),
         utils::View(valid_apps_df),
         call. = FALSE)
    }
    
   
    dir <- system.file('apps', app_name, package = 'teachingApps')
  
    teachingApps::add_options(opts = more_opts,
                              dir = dir,
                              theme = theme,
                              icon = icon,
                              img = img,
                              git_user = git_user)
    
    shiny::shinyAppDir(appDir = dir, 
                       options = list(height = height, width = width,...))

}