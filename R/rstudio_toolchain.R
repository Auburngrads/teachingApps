rstudio_toolchain<- function() {

    app <- source(system.file("apps", "rstudio_toolchain.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
