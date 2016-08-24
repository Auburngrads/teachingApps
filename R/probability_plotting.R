probability_plotting<- function() {

    app <- source(system.file("apps", "probability_plotting.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
