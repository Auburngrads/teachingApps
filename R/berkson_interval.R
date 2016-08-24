berkson_interval <- function() {

    file <- system.file("apps", "berkson_interval.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
