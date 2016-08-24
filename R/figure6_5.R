figure6_5 <- function() {

    file <- system.file("apps", "figure6_5.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
