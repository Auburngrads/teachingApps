lfp1370_data <- function() {

    file <- system.file("apps", "lfp1370_data.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
