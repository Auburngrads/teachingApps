basic_histogram<- function() {

    app <- source(system.file("apps", "basic_histogram.R", package = "teachingApps"))
  
  eval(as.call(app))
  
}
