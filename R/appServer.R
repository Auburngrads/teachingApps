#' Nest the server of a smaller app within the server of larger app
#'
#' @param appName The name of the "smaller" app from which the server will be pulled
#' @param pkg The package in which \code{appName} exists
#' @param envir The environment in which the call is made typically \code{environment()}
#'
#' @export

nestServer <- function(appName, envir = NULL, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'server.R', package = pkg)
  serve <- source(file = file)
  texts <- parse(text = body(serve[[1]])[-1])
  
  eval(texts, envir = envir)
}


#' Nest the UI of smaller app within the UI of a larger app
#'
#' @param appName The name of "smaller" app from which the UI will be pulled
#' @param pkg The package in which \code{appName} exists
#'
#' @export

nestUI <- function(appName, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'ui.R', package = pkg)
  serve <- source(file = file)
  
  # serve2 <- gsub('<div style="right:40%;bottom:3%;height:30px;position:fixed;cursor:inherit;">
  #   <div id="sign" class="shiny-html-output"></div>
  # </div>','',serve[[1]])
  # 
  # serve3 <- gsub('<div class=\"container-fluid\">','',serve2)
  # serve4 <- gsub('<', '\\\\<', serve3)
  
  return(serve[[1]])
  
}

#' Nest an rmarkdown file within an app
#' 
#' @importFrom shiny getShinyOption withMathJax HTML
#' @importFrom knitr knit
#' @importFrom markdown markdownToHTML 
#' 
#' @param rmd An rmarkdown file saved in the app directory
#'
#' @export

nestRmd <- function(rmd) {
  
  rmd <- paste(c(getShinyOption('appDir'),rmd), collapse = '/')
   withMathJax(HTML(markdown::markdownToHTML(knitr::knit(rmd))))
  
}

