random_generator <- function() {

    file <- system.file("apps", "random_generator.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
