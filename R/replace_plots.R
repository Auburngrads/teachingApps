replace_plots<- function() {

    app <- source(system.file("apps", "replace_plots.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
