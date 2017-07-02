#' Pass objects and customization options to a shiny app
#' 
#' @description Provides a general method for passing arguments to shiny apps
#'     each using \code{shiny::shinyOptions}.
#'     
#' @details Passing a customization option as a \code{shiny::shinyOption} 
#'    ensures the option is carried through to app deployment. 
#' 
#' @importFrom shiny getShinyOption shinyOptions HTML
#'
#' @param opts A \code{list} of additional options or objects to pass to a shiny app
#' @param dir A \code{character} string indicating the path to the directory containing ui.R and server.R
#' @param theme A \code{character} string naming a Bootswatch color theme (used by \code{shinythemes::shinytheme})
#' @param icon  A \code{character} string naming a fontAwesome icon to be placed in the footer of a navbarPage app
#' @param img A \code{character} string for the path/url of an image to be placed in the footer of a navbarPage app
#' @param git_user A \code{character} string for github username used in the branding link
#'
#' @details Shiny apps are not functions, therefore customization options cannot be
#'     passed to a shiny app as simply as argument are passed between functions.  Further,
#'     the manner in which objects are loaded prior to deploying an app differ if the app
#'     will be published as a stand-alone or embedded within an rmarkdown docmuent.
#'     Assigning objects to shiny options ensures that these values are passed to a shiny
#'     app much the same way as arguments are passed to functions.
#'   
#' @return A list of options set with \code{shinyOptions} 
#' @export
add_shiny_opts <- 
function(opts, 
         dir, 
         theme = 'flatly', 
         icon = NULL,
         img = img,
         git_user = git_user) 
{

if(!is.na(opts)) { 
aso <- lapply(X = 1:length(opts), 
       FUN = function(x) {
             eval(parse(text = paste(collapse = '',
                                     c('shiny::shinyOptions(',
                                       names(opts[x]),
                                       '=',
                                       opts[x],
                                       ')'))))
       })
}
    if(is.null(icon)) icon = 'fa fa-github'
         
    logo <- HTML(teachingApps::create_logo(dir, 
                                           icon = icon, 
                                           img = img,
                                           git_user = git_user))
    
     CSS <- system.file('teachingApps','css','teachingApps.css', package = 'teachingApps')
    
    shiny::shinyOptions('theme'   = theme)
    shiny::shinyOptions('appDir'  = dir)
    shiny::shinyOptions('appName' = basename(dir))
    shiny::shinyOptions('CSS'     = CSS)
    shiny::shinyOptions('logo'    = logo)
} 
