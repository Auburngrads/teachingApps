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