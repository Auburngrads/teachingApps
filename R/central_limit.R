central_limit <- function() {

    file <- system.file("apps", "central_limit.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
