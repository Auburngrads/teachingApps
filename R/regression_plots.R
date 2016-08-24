regression_plots<- function() {

    app <- source(system.file("apps", "regression_plots.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
