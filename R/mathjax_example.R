mathjax_example <- function() {

    file <- system.file("apps", "mathjax_example.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
