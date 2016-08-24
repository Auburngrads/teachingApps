distribution_lognormal<- function() {

    app <- source(system.file("apps", "distribution_lognormal.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
