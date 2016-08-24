basic_histogram <- function() {

    file <- system.file("apps", "basic_histogram.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
