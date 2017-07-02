#' Add CSS style rules to an teachingApp 
#'
#' @importFrom shiny getShinyOption tags
#' 
#' @return teachingApps style rules defined to an app
#' @seealso \link{\code{add_theme}}
#' @export
add_css <- function()
{
  main <- tags$head(tags$link(rel = 'stylesheet', 
                              type = 'text/css',
                              href = 'teachingApps/css/teachingApps.css'))
                   
  return(main)
}
