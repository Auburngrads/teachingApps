plotting_special<- function() {

    app <- source(system.file("apps", "plotting_special.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
