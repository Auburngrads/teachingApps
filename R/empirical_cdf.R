empirical_cdf<- function() {

    app <- source(system.file("apps", "empirical_cdf.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
