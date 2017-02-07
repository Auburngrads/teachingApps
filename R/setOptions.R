#' Save a local package directory as an environment variable
#'
#' @param pkg Name of a package
#' @param local.dir Path to the local directory at which \code{pkg} is located
#' @param git.user The GitHub username
#' 
#' @export

setOptions <- 
function(local.dir = NULL, pkg = NULL, git.user = NULL) {
  
  #if (missing(pkg)) stop('Required variable "pkg" missing')
  
  if(is.null(local.dir) | is.null(pkg)) {
    
    local.dir <- do.call(getwd, args = list())
    pkg <- basename(local.dir)
  }
  
  args = list(local.dir,pkg,git.user)
  
  names(args) = c(pkg,'appPackage','git.username')
  
  do.call(options, args)
  
}
