#' Quickly update the code for a shiny app
#'
#' @importFrom utils browseURL
#'
#' @param repo Name of the directory in which the raw app code is stored
#' @param pkg Name of the package in which the updates are to be made.  Defaults to \code{repo}.
#' @param lib Package library directory where \code{pkg} is stored. Defaults to \code{.libPaths()[1]}
#' @param app Name of the app to be updated
#' @param open.folder If \code{TRUE}, \code{browseURL()} is called to open view the files in the app directory
#' @param css Logical variable indicating if the css files should be updated
#' @param create Logical inidicating if a new app directory should be created
#' @param git Local directory in which git repositories are stored (see details)
#' 
#' @details This function assumes that the raw app code is in the \code{inst/} directory
#' Prior to using this function the default git directory must be established in \code{options} using \code{teachingApps::setGit()} 
#' 
#' @export

updateApp <- 
function(app = NULL, repo = 'teachingApps', pkg = repo,
                      lib = .libPaths()[1], open.folder = FALSE, 
                      css = FALSE, create = FALSE, git = NULL) {
  
  if(is.null(git)) {
    
    if(is.null(getOption('gitHome'))) { 
    
    stop('git directory must either be specified or set using teachingApps::setGit()')
    
    } else { git <- getOption('gitHome') 
    }
    }
  
  gitRoot <- paste(c(git, repo, 'inst'), collapse = '/')
  
  libRoot <- paste(c(lib, pkg), collapse = '/')

  if(!is.null(app)) {
    
    if(dir.exists(paste(c(gitRoot, 'apps', app), collapse = '/'))) {

      appRoot <- paste(c(gitRoot, 'apps', app), collapse = '/') 
      
    if(open.folder) { utils::browseURL(appRoot)
      
    } else {
    
    appFiles <- list.files(path = appRoot)
      
    for(i in 1:length(appFiles)) {
      
    file.copy(from = paste(c(gitRoot, 'apps', app, appFiles[i]), collapse = '/'), 
              to   = paste(c(libRoot, 'apps', app, appFiles[i]), collapse = '/'),
              overwrite = T) 
    }
    }
    } else { 
      
    if(!create) {
      
      stop(paste(c('App ',app,' does not exist. To create this app set create = TRUE'), collapse = ''))
    
    } else {
      
      appRoot <- dir.create(paste(c(gitRoot, 'apps',app), collapse = '/'))
    }
    }
    }
  
    if(css) {
    
    cssFiles <- list.files(path = paste(c(gitRoot, 'resources','css'), collapse = '/'))
    
    for(i in 1:length(cssFiles)) {
      
    file.copy(from = paste(c(gitRoot, 'css', cssFiles[i]), collapse = '/'), 
              to   = paste(c(libRoot, 'css', cssFiles[i]), collapse = '/'),
              overwrite = T) 
}    
}  
}