censoring_types <- function() {

    file <- system.file("apps", "censoring_types.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
