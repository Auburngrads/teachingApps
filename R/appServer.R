#' Insert an app server into a storyteller app
#'
#' @param appName The app from which the UI is pulled
#' @param envir The environment in which the call is made typically \code{environment()}
#' @param pkg The package in which the \code{appName} exists
#'
#' @export

insertServer <- function(appName, envir = NULL, pkg = 'teachingApps') {
  
  file  <- system.file('apps', appName, 'server.R', package = pkg)
  serve <- source(file = file)
  texts <- parse(text = body(serve[[1]])[-1])
  
  eval(texts, envir = envir)
}


#' Insert an app UI into a storyteller app
#'
#' @param appName The app from which the UI is pulled
#' @param pkg The package in which the \code{appName} exists
#'
#' @export

insertUI <- function(appName, pkg = 'teachingApps') {
  
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

#' Insert an rmarkdown file within a storyteller app
#'
#' @param rmd An rmarkdown file saved in the app directory
#'
#' @export

insertRmd <- function(rmd) {
  
  #rmd <- paste(c(dir,rmd), collapse = '/')
  
  withMathJax(HTML(markdown::markdownToHTML(knitr::knit(rmd))))
  
}

