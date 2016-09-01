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

eval(substitute(ifelse(!a%in%installed.packages(),
                       {install.packages(a, repos = 'http://cran.rstudio.com') ; requireNamespace(a)},
                       requireNamespace(a)),
                list(a = pkg)))

  } else {

eval(substitute(ifelse(!a%in%installed.packages(),
                       {devtools::install_github(paste(c(b,a), collapse = '/')) ; requireNamespace(a) },
                       requireNamespace(a)),
                list(a = pkg, b = repo)))

}
}