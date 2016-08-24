data_science <- function() {

    file <- system.file("apps", "data_science.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
