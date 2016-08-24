berkson_interval<- function() {

    app <- source(system.file("apps", "berkson_interval.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
