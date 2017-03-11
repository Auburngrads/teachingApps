#' Quickly update the code for a shiny app
#'
#' @importFrom utils browseURL
#'
#' @param pkg Name of the package in which the updates are to be made.  Defaults to \code{repo}.
#' @param lib Package library directory where \code{pkg} is stored. Defaults to \code{.libPaths()[1]}
#' @param app Name of the app to be updated
#' @param open.folder If \code{TRUE}, \code{browseURL()} is called to open view the files in the app directory
#' @param css Logical variable indicating if the css files should be updated
#' @param local.dir Path to the package directory in which the raw app code is stored
#'  
#' @details This function assumes that the raw app code is in the \code{inst/} directory
#' Prior to using this function the default git directory must be established in \code{options} using \code{teachingApps::setGit()} 
#' 
#' @export

updateApp <- 
function(app = NULL, pkg = 'teachingApps', 
         lib = .libPaths()[1], open.folder = FALSE, 
         css = FALSE, local.dir = NULL) {
  
  if(is.null(local.dir)) {
    
    `if`(is.null(getOption(pkg)),
         stop('Argument "local.dir" must either be specified\n or set using teachingApps::setOptions()'),
         local <- getOption(pkg) )
    
  } else {
      
    local <- normalizePath(local.dir)
    
  }

  
  localRoot <- paste(c(local, 'inst'), collapse = '/')
  
    libRoot <- paste(c(lib, pkg), collapse = '/')

  if(!is.null(app)) {
    
    if(dir.exists(paste(c(localRoot, 'apps', app), collapse = '/'))) {

      appRoot <- paste(c(localRoot, 'apps', app), collapse = '/') 
      
    if(open.folder) { utils::browseURL(appRoot)
      
    } else {
    
    appFiles <- list.files(path = appRoot, recursive = T)
      
    for(i in 1:length(appFiles)) {
      
    file.copy(from = paste(c(localRoot, 'apps', app, appFiles[i]), collapse = '/'), 
              to   = paste(c(  libRoot, 'apps', app, appFiles[i]), collapse = '/'),
              overwrite = T) 
    }
    }
    } else { 
      
      stop(paste(c('App "',app,'" does not exist.\n\n use teachingApps::newApp to create a new app'), collapse = ''))
    
    }
    }
  
    if(css) {
    
    cssFiles <- list.files(path = paste(c(localRoot, 'resources','css'), collapse = '/'))
    
    for(i in 1:length(cssFiles)) {
      
    file.copy(from = paste(c(localRoot, 'css', cssFiles[i]), collapse = '/'), 
              to   = paste(c(  libRoot, 'css', cssFiles[i]), collapse = '/'),
              overwrite = T) 
}    
}  
}