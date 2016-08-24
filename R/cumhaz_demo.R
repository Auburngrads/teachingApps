cumhaz_demo<- function() {

    app <- source(system.file("apps", "cumhaz_demo.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
