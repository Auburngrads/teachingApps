basic_dashboard <- function() {

    file <- system.file("apps", "basic_dashboard.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
