distribution_exponential_full<- function() {

    app <- source(system.file("apps", "distribution_exponential_full.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
