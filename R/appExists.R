#' Determine if an app exists in a package
#' 
#' Determines whether the package in the library or in a local directory
#'
#' @param what A \code{list} returned from \code{teachingApps:::what_are_you} 
appExists <- function(lib.list, app) {
  
  if(!is.list(lib.list)) stop('Argument "lib.list" must be a list returned from teachingApps:::what_are_you')
  
  in_lib <- lapply(X = 1:length(.libPaths()), 
                   FUN = function(x) grepl(.libPaths()[x], lib.list))
  
  `if`(any(unlist(in_lib)),
       root <- file.path(lib.list$pkgroot, 'apps', app),
       root <- file.path(lib.list$pkgroot, 'apps', app))
  
   if(!dir.exists(root)) stop('The named app could not be found in the specified package')
  
}