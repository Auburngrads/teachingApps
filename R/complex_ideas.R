complex_ideas<- function() {

    app <- source(system.file("apps", "complex_ideas.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
