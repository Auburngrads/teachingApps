distribution_binomial<- function() {

    app <- source(system.file("apps", "distribution_binomial.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
