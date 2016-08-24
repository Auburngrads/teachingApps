soln_numerical <- function() {

    file <- system.file("apps", "soln_numerical.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
