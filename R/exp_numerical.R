exp_numerical <- function() {

    file <- system.file("apps", "exp_numerical.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
