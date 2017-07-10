#' Determine what a thing is
#'
#' @param thing \code{character} A package name, directory, or file path
#'
#' @importFrom rprojroot find_root
#' @importFrom rprojroot is_r_package  
#' @importFrom utils installed.packages
#' 
what_are_you <- function(thing) {
  pkgname <- NULL
  pkgroot <- NULL
  approot <- NULL
  is_package <- FALSE
  thepath <- NULL
    
  if(is.null(thing)) { 
    
    thepath <- '~'
    
  } else {
    
  is_pkg1 <- thing%in%installed.packages()
  
  is_pkg2 <- !is.error(rprojroot::find_root(rprojroot::is_r_package, path = thing))
  is_package <- is_pkg1 | is_pkg2
  
  if(!is_package) {
    
    is_app <- !is.error(rprojroot::find_root(rprojroot::is_shiny_app, path = thing))
    
    if(is_app) { 
      
      thepath <- rprojroot::find_root(rprojroot::is_shiny_app, path = thing)
    
    } else {
      
      `if`(R.utils::isDirectory(thing),
         thepath <- thing,
         thepath <- dirname(thing))
      
    }
    
  } else {
  
  if(is_pkg2) {
    
    pkgroot <- rprojroot::find_root(rprojroot::is_r_package, path = thing)
    
    `if`(!any(dirname(pkgroot)%in%.libPaths()),
         { pkgroot <- file.path(pkgroot,'inst')
           pkgname <- basename(dirname(pkgroot)) },
           pkgname <- basename(pkgroot))
       
  } 
  if(is_pkg1) {
    
    pkgroot <- system.file(package = thing)
    pkgname <- thing
  }
  }
  }
  
  zzz <- list()
  zzz$package <- is_package
  zzz$pkgname <- pkgname
  zzz$pkgroot <- pkgroot
  zzz$path    <- thepath
  zzz$approot <- approot
  
  return(zzz)
}