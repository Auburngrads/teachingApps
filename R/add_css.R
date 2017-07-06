#' Add teachingApps CSS style rules to an app 
#'
#' @importFrom shiny getShinyOption tags
#' @details This function should not be called directly but must be 
#'          be included within the body of an app's \code{ui} 
#' @return teachingApps style rules defined to an app
#' @seealso \code{\link{add_theme}}
#' @export
add_css <- function()
{
  main <- tags$head(tags$link(rel = 'stylesheet', 
                              type = 'text/css',
                              href = 'teachingApps/css/teachingApps.css'))
                   
  return(main)
}
