table3_5<- function() {

    app <- source(system.file("apps", "table3_5.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
