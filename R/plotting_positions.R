plotting_positions<- function() {

    app <- source(system.file("apps", "plotting_positions.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
