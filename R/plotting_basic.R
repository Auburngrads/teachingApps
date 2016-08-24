plotting_basic<- function() {

    app <- source(system.file("apps", "plotting_basic.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
