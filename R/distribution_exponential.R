distribution_exponential<- function() {

    app <- source(system.file("apps", "distribution_exponential.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
