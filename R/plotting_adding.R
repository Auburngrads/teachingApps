plotting_adding<- function() {

    app <- source(system.file("apps", "plotting_adding.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
