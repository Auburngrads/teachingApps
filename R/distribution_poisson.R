distribution_poisson<- function() {

    app <- source(system.file("apps", "distribution_poisson.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
