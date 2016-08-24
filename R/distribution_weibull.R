distribution_weibull<- function() {

    app <- source(system.file("apps", "distribution_weibull.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
