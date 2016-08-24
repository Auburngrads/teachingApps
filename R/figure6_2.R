figure6_2 <- function() {

    file <- system.file("apps", "figure6_2.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
