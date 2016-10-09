#' Quickly update the code for a shiny app
#'
#' @param repo Name of the directory in which the raw app code is stored
#' @param pkg Name of the package in which the updates are to be made.  Defaults to \code{repo}.
#' @param lib Package library directory where \code{pkg} is stored. Defaults to \code{.libPaths()[1]}
#' @param app Name of the app to be updated
#' @param open.folder If \code{TRUE}, \code{browseURL()} is called to open view the files in the app directory
#' @param css Logical variable indicating if the css files should be updated
#' 
#' @details This function assumes that the raw app code is in the \code{inst/} directory   
#' 
#' @export

updateApp <- function(repo = NULL, pkg = repo, lib = .libPaths()[1], app = NULL, open.folder = FALSE, css = FALSE) {
  
  gitRoot <- paste(c('C:/Users/Jason/OneDrive/Work-Stuff/Computer Systems/GitHub/',
                   package,
                   '/inst'), 
                 collapse = '')
  
  libRoot <- paste(c(lib,package), collapse = '/')

  if(!is.null(app)) {
    
    appRoot <- paste(c(gitRoot, 'apps',app), collapse = '/')
    
    appFiles <- list.files(path = appRoot)
    
    if(open.folder) { browseURL(appRoot)
      
    } else {
    
    for(i in 1:length(appFiles)) {
      
    file.copy(from = paste(c(gitRoot, 'apps', app, appFiles[i]), collapse = '/'), 
              to   = paste(c(libRoot, 'apps', app, appFiles[i]), collapse = '/'),
              overwrite = T) 
}
}
}

    if(css) {
    
    cssFiles <- list.files(path = paste(c(gitRoot, 'css'), collapse = '/'))
    
    for(i in 1:length(cssFiles)) {
      
    file.copy(from = paste(c(gitRoot, 'css', cssFiles[i]), collapse = '/'), 
              to   = paste(c(libRoot, 'css', cssFiles[i]), collapse = '/'),
              overwrite = T) 
}    
}  
}