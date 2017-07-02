#' Add CSS style rules to an teachingApp 
#'
#' @importFrom shiny getShinyOption tags
#' 
#' @return Style rules defined by teachingApps.css
#' 
#' @export
add_css <- function()
{
  main <- tags$head(tags$link(rel = 'stylesheet', 
                              type = 'text/css',
                              href = 'teachingApps/css/teachingApps.css'))
                   
  return(main)
}
