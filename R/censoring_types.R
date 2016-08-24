censoring_types<- function() {

    app <- source(system.file("apps", "censoring_types.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
