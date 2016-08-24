mathjax_example<- function() {

    app <- source(system.file("apps", "mathjax_example.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
