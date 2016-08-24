offbase_libraries<- function() {

    app <- source(system.file("apps", "offbase_libraries.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
