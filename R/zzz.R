.onLoad <- function(libname, pkgname) {
  
  # library(SMRD)
  # library(ggplot2)
  # 
  # datas <- list(diamonds = diamonds)
  # 
  # devtools::use_data(datas, internal = T, overwrite = T)
  
jkf.par <<- function(...) {
    
    par(cex.lab=1.05,
        cex.axis=1.05,
        mgp=c(2.25,.7,0),
        tcl=-.3,
        font.lab=2,
        font=2,
        font.axis=2,
        las=1,
        tck=0.015,
        family='serif',...)
}
}

#' Leave signature for teachingApps 
#'
#' @param name The name of the app \code{character}
#'
#' @export

teachingApp <- function(name) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitFile <- paste(c(name,'.R'), collapse = '')
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/R'
  
    return(paste(c("<div style='font-size: 22pt; font-weight: bold;'>Get the <a href='",
                paste(c(gitURL, gitFile), collapse = '/'),"'>CODE</a> for this app</div>"), collapse = ''))
    
}

createFun <- function() {
  
  file = "C:\\Users\\Jason\\OneDrive\\Work-Stuff\\Computer Systems\\GitHub\\teachingApps\\inst\\apps\\acceptance_mtbf.R"
  
  dir = dirname(file)
  
  names <- gsub('.R', '', list.files(dir))
  
  for(i in 1:length(names)) {
    
    text <- paste(c(names[i],'<- function() {

    app <- source(system.file("apps", "', names[i],'.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}'), collapse = '')
  
    file2 <- "C:\\Users\\Jason\\OneDrive\\Work-Stuff\\Computer Systems\\GitHub\\teachingApps\\R\\zzz.R"
    dir2  <- dirname(file2)
    
    writeLines(text = text, con = paste(c(dir2,'/',names[i],'.R'), collapse = ''))
}
}