reliability_environment<- function() {

    app <- source(system.file("apps", "reliability_environment.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
