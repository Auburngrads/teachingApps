#' Installs and/or loads an R package
#'
#' @export
#' 
#' @param pkg Name of a package to be installed/loaded (as a character string)
#' @param repo The repository from which the package should be installed.
#' @param pub \code{logical} variable indicating whether the app be published (see details) 
#' 
#' @importFrom devtools install_github
#' @importFrom utils install.packages
#' @importFrom utils installed.packages
#'
#' @details If \code{repo = NULL} the package will be installed from the CRAN.  Otherwise, \code{repo} is a character string that referring to the GitHub account in which the package is located.
#' 
#'   When publishing apps on shinyapps.io or shinyServer, attempting to \code{install.packages} will result in an error.  Calls to \code{install.packages} should not be included within an app.

getPackage <- function(pkg = NULL, repo = NULL, pub = TRUE ) {

  if(pub) {
    
    do.call(library, list(package = pkg, character.only = TRUE))
    
  } else {
  
  if(is.null(repo)) {

if(!pkg%in%installed.packages()) install.packages(pkg, repos = 'http://cran.rstudio.com') 
  
  } else {

if(!pkg%in%installed.packages()) devtools::install_github(paste(c(repo,pkg), collapse = '/')) 
  
  }
  }
  }