data_patterns <- function() {

    file <- system.file("apps", "data_patterns.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
