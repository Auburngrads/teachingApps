#' Function Title
#'
#' @description Description
#'
#' @param path file path
#'  
#' @details When publishing apps using shinyapps.io or shinyServer, set code{pub = TRUE} to prevent calls to code{install.packages}. Calls to code{install.packages} should not be included within an app and will result in an error.
#'
#' @export

includeArgs <- function (path) {
  
    lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
    lines <- gsub('\r\n','', lines)
    return(as.character(eval(parse(text = lines))))
    
}