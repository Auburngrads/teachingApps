crossing_distributions<- function() {

    app <- source(system.file("apps", "crossing_distributions.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
