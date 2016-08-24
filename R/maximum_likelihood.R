maximum_likelihood<- function() {

    app <- source(system.file("apps", "maximum_likelihood.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
