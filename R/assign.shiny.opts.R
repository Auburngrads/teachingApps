#' Pass objects and customization options to apps
#' 
#' @description Provides a general method pass arguments to shiny apps
#' and ensure the options carry through to app deployment. 
#' 
#' @importFrom shiny getShinyOption shinyOptions HTML
#'
#' @param opts \code{list} Additional options or objects to pass to a shiny app
#' @param dir \code{character} Path to the directory containing ui.R and server.R
#' @param theme \code{character} Bootswatch color theme (used by \code{shinythemes::shinytheme})
#' @param story \code{logical} Is this a storyteller app?
#' @param css \code{character} Path to a custom css file 
#'
#' @details Shiny apps are not functions, therefore customization options cannot be
#' passed to a shiny app as simply as argument are passed between functions.  Further,
#' the manner in which objects are loaded prior to deploying an app differ if the app
#' will be published as a stand-alone or embedded within an rmarkdown docmuent.
#' 
#' Assigning objects to shiny options ensures that these values are passed to a shiny
#' app much the same way as arguments are passed to functions.
#'   
#' @return A list of options set with \code{shinyOptions} 
#' @export

assign.shiny.opts <- 
function(opts, dir, theme = 'flatly', 
         story = F) {

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

    CSS <- system.file('resources','css','teachingApps.css', package = 'teachingApps')
                
    
    sign <- `if`(story,
                 HTML(teachingApps::signature(basename(dir))),
                 HTML(teachingApps::signature(basename(dir))))
    
    shiny::shinyOptions('theme'   = theme)
    shiny::shinyOptions('appDir'  = dir)
    shiny::shinyOptions('appName' = basename(dir))
    shiny::shinyOptions('story'   = story)
    shiny::shinyOptions('CSS'     = CSS)
    shiny::shinyOptions('css'     = file.path(dir, 'www','custom.css'))
    shiny::shinyOptions('sign'    = sign)
    
    if(!story)
       options('markdown.HTML.stylesheet' = shiny::getShinyOption("CSS"))

} 
