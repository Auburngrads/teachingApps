data_patterns<- function() {

    app <- source(system.file("apps", "data_patterns.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
