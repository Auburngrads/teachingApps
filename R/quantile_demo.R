quantile_demo<- function() {

    app <- source(system.file("apps", "quantile_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
