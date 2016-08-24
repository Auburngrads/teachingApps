figure10_4 <- function() {

    file <- system.file("apps", "figure10_4.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
