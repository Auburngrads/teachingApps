#' Install and load an R package
#' @return A printed shiny app
#' @export
#' 
#' @param pkg \code{character} Name of a package to be installed/loaded
#' @param repo \code{character} Name of the repository from which the package should be installed.
#' @param pub \code{logical} variable indicating whether the app be published (see details) 
#' 
#' @importFrom devtools install_github
#' @importFrom devtools install_cran
#' @importFrom utils installed.packages
#' @importFrom yaml yaml.load_file
#' @importFrom magrittr %>%
#'
#' @details If \code{repo = NULL} the package will be installed from the CRAN.  Otherwise, \code{repo} is a character string that referring to the GitHub account in which the package is located.
#' 
#'   When publishing apps on shinyapps.io or shinyServer, attempting to \code{install.packages} will result in an error.  Calls to \code{install.packages} should not be included within an app.
add_packages <- 
function(pkg = NULL, 
         repo = NULL, 
         pub = FALSE ) 
{

  if(is.null(pkg) || missing(pkg)) {
    
    meta <- yaml::yaml.load_file('www/metadata.yaml')
    
     pkgs <- gsub(meta$packages, ' ', '') %>%
             strsplit(split = ',')        %>%
             unlist()
    
    repos <- gsub(meta$repos, ' ', '')    %>%
             strsplit(split = ',')        %>%
             unlist()
    
  if(length(pkgs) != length(repos)) stop('Number of packages and repos is not equal')

  }
  
  for(i in 1:length(pkgs)) {
    
  if(!pub) {
    
  if(tolower(repos[i])=='cran' || is.null(repos[i])) {
    
if(!pkgs[i]%in%installed.packages()) do.call('install_cran', args = list(pkgs = pkg[i], repos = getOption('repos')))
  
  } else {
    
if(!pkgs[i]%in%installed.packages()) do.call('install_github', args = list(repo = paste0(c(repos[i],'/',pkgs[i])))) 
  
  }
    }
  
  do.call('library', list(package = pkg, pos = 2, character.only = T))
  
  }
}
