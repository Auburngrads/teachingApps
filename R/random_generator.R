random_generator<- function() {

    app <- source(system.file("apps", "random_generator.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
