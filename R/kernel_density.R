kernel_density <- function() {

    file <- system.file("apps", "kernel_density.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
