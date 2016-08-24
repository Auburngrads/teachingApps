at7987_data<- function() {

    app <- source(system.file("apps", "at7987_data.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
