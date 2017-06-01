#######################################################
#
#######################################################
uiActionSidebarMenu <- function(config) {
  if(config$isRunningInProduction) {
    actionSidebarMenuResult <- sidebarMenu(
      menuItem("Tool Overview", tabName = "Tool", icon = icon("info")),
      menuItem("Load-Filter-Explore", tabName = "AFDs", icon = icon("database")),
      menuItem("New Tab", tabName = "NT", icon = icon("dashboard"),
         menuSubItem('New Sub Tab', tabName = 'NST', icon = icon('dashboard'))
      ),
      menuItem("Take Action",tabName="ACT",icon=icon('rocket'))
    )
    return (actionSidebarMenuResult)
  }
  else {
    actionSidebarMenuResult <- sidebarMenu(
      menuItem("Tool Overview", tabName = "Tool", icon = icon("info")),
      menuItem("Load Data Files",tabName="Data",icon=icon("file")),
      menuItem("New Tab", tabName = "NT", icon = icon("dashboard"),
         menuSubItem('New Sub Tab', tabName = 'NST', icon = icon('dashboard'))
      ),
      menuItem("Take Action",tabName="ACT",icon=icon('rocket'))
    )
    return (actionSidebarMenuResult)
  }
}


#######################################################
#
#######################################################
uiNonActionSidebarMenu <- function(config) {
  if(config$isRunningInProduction) {
    nonActionAidebarMenuResult <- sidebarMenu(
      menuItem("Tool Overview", tabName = "Tool", icon = icon("info")),
      menuItem("Load-Filter-Explore", tabName = "AFDs", icon = icon("database"))
    )
    return (nonActionAidebarMenuResult)
  }
  else {
    nonActionAidebarMenuResult <- sidebarMenu(
      menuItem("Tool Overview", tabName = "Tool", icon = icon("info")),
      menuItem("Load Data Files",tabName="Data",icon=icon("file"))
    )
    return (nonActionAidebarMenuResult)
  }
}
