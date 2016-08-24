likelihood_ace<- function() {

    app <- source(system.file("apps", "likelihood_ace.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
