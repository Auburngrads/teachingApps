turbine_data6 <- function() {

    file <- system.file("apps", "turbine_data6.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
