plotting_par<- function() {

    app <- source(system.file("apps", "plotting_par.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
