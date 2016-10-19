#' Function Title
#'
#' @param app The app directory in which the file is located
#' @param file The name of the desired file
#' @param pkg The name of the package in which to search
#' 
#' @details This function assumes that the apps are stored in a package directory called 'apps'
#'
#' @export

appFile <- function(app, file, pkg = 'teachingApps') {
  
  system.file('apps',app,file, package = pkg)
  
}