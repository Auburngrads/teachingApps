distribution_hypergeometric<- function() {

    app <- source(system.file("apps", "distribution_hypergeometric.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
