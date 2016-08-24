confidence_intervals<- function() {

    app <- source(system.file("apps", "confidence_intervals.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
