maximum_likelihood_full<- function() {

    app <- source(system.file("apps", "maximum_likelihood_full.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
