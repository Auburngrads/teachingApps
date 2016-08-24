program_costs <- function() {

    file <- system.file("apps", "program_costs.R", package = "teachingApps")

    lines <- parse(text = readLines(file))
  
    eval(as.call(lines))
  
}
