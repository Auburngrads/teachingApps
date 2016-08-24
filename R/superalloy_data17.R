superalloy_data17<- function() {

    app <- source(system.file("apps", "superalloy_data17.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
