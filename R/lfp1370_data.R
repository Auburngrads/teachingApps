lfp1370_data<- function() {

    app <- source(system.file("apps", "lfp1370_data.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
