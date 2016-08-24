crossing_distributions2<- function() {

    app <- source(system.file("apps", "crossing_distributions2.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
