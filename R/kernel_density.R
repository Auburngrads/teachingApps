kernel_density<- function() {

    app <- source(system.file("apps", "kernel_density.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
