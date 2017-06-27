#' Install and load an R package
#' @return A printed shiny app
#' @export
#' 
#' @param pkg \code{character} Name of a package to be installed/loaded
#' @param repo \code{character} Name of the repository from which the package should be installed.
#' @param pub \code{logical} variable indicating whether the app be published (see details) 
#' 
#' @importFrom devtools install_github
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#'
#' @details If \code{repo = NULL} the package will be installed from the CRAN.  Otherwise, \code{repo} is a character string that referring to the GitHub account in which the package is located.
#' 
#'   When publishing apps on shinyapps.io or shinyServer, attempting to \code{install.packages} will result in an error.  Calls to \code{install.packages} should not be included within an app.
getPackage <- 
function(pkg = NULL, repo = NULL, pub = FALSE ) {
  if(!pub) {
    
  if(is.null(repo)) {
if(!pkg%in%installed.packages()) do.call('install.packages', args = list(pkg = pkg, repos = 'http://cran.rstudio.com'))
  
  } else {
if(!pkg%in%installed.packages()) do.call('install_github', args = list(repo = paste(c(repo,pkg), collapse = '/'))) 
  
  }
  }
  do.call('library', list(package = pkg, pos = 2, character.only = T))
  }
