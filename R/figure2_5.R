figure2_5 <- function() {

    file <- system.file("apps", "figure2_5.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
