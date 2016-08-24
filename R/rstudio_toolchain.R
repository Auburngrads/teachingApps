rstudio_toolchain <- function() {

    file <- system.file("apps", "rstudio_toolchain.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
