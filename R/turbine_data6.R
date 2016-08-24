turbine_data6<- function() {

    app <- source(system.file("apps", "turbine_data6.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
