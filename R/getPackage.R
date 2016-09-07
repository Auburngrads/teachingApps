#' Installs and/or loads an R package
#'
#' @export
#' 
#' @param pkg Name of a package to be installed/loaded (as a character string)
#' @param repo The repository from which the package should be installed. 
#' 
#' @importFrom devtools install_github
#'
#' @details If \code{repo = NULL} the package will be installed from the CRAN.  Otherwise, \code{repo} is a character string that referring to the GitHub account in which the package is located  

getPackage <- function(pkg = NULL, repo = NULL) {

  if(is.null(repo)) {

if(!pkg%in%installed.packages()) {
  
  install.packages(pkg, repos = 'http://cran.rstudio.com') 
  
      do.call(library, list(package = pkg, character.only = TRUE))
  
  } else { do.call(library, list(package = pkg, character.only = TRUE)) }

                      } else {

if(!pkg%in%installed.packages()) {
  
  devtools::install_github(paste(c(b,a), collapse = '/')) 
  
      do.call(library, list(package = pkg, character.only = TRUE))
  
  } else { do.call(library, list(package = pkg, character.only = TRUE)) }

}
}