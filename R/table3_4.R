table3_4<- function() {

    app <- source(system.file("apps", "table3_4.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
