.onLoad <- 
function(libname, pkgname) {
shiny::addResourcePath("teachingApps", 
                       system.file("teachingApps", package = "teachingApps"))  
  
shiny::shinyOptions('theme' = 'flatly')
}
#' Custom \code{par} function
#' 
#' @param ... Parameter passed to \code{par} in addition to those defined
#' 
#' @importFrom graphics par
#' 
#' @export
jkf.par <- 
function(...) {
    
    par(cex.lab = 1.05,
        cex.axis = 1.05,
        mgp = c(2.25,.7,0),
        tcl = -.3,
        font.lab = 2,
        font = 2,
        font.axis = 2,
        las = 1,
        tck = 0.015,
        family = 'serif',...)
}

add_less <- function() {
  
  cmd <- paste0("lessc ","inst\\scripts\\less\\flatslidy.less", " inst\\scripts\\css\\flatslidy.css")

system(cmd)
}