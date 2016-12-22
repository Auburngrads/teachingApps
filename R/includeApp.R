#' Include Shiny apps in documents and presentations
#'
#' @param appUrl The prefix of the app URL, as a character string (see \code{details})
#' @param appName The name of the app, as a character string
#' @param ... Additional commands provided to \code{knitr::include_app}
#' @importFrom knitr include_app
#' 
#' @description This function is a wrapper for \code{knitr::include_app} adding the app's URL prefix  
#' 
#' @details The app prefix is often of the form 'https://accountname.shinyapps.io'
#' 
#' @export
#'

includeApp <- 
function(appName, appUrl = NULL,...) {
  
  if(is.null(appUrl)) appUrl <- getOption('appURL')
  
  app <- paste(c(appUrl, appName), collapse = '')
  
  knitr::include_app(app,...)
  
}