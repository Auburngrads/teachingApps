distribution_gamma<- function() {

    app <- source(system.file("apps", "distribution_gamma.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
