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

teachingApp <- function(name, css = TRUE,...) {
  
  if(!is.character(name)) stop('name must be a character string')
  
  gitFile <- paste(c(name,'.R'), collapse = '')
  gitPath <- "C:/Users/Jason/OneDrive/Work-Stuff/Computer Systems/GitHub/teachingApps/R"
  gitURL  <- 'https://github.com/Auburngrads/teachingApps/blob/master/R'
  
  if(css) {
    
    cat(paste(c("<div style='font-size: 22pt; margin: 0 0 20px 30px; font-weight: normal;'>Get the [code](",
                paste(c(gitURL, gitFile), collapse = '/'),') for this app on GitHub</div>'), collapse = ''))
    
  } else {
    
    paste(c(gitURL, gitFile), collapse = '/')
    
  }
}


}