bent_probplot<- function() {

    app <- source(system.file("apps", "bent_probplot.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
