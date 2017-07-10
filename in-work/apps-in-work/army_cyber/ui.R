################USER INTERFACE BUILD####################
#create the User Interface
ui <- dashboardPage(
  skin = "green",
  dashboardHeader(title = config$title),
  dashboardSidebar(
    imageOutput("image", height = "auto",width="auto", inline=FALSE),
    sidebarMenu(
      id="tabs",
      sidebarMenuOutput('menuSidebar')
    )
  ),
  dashboardBody(
    tabItems(
      uiToolTabItem(),
      uiDataTabItem(config),
      uiAfdTabItem(config),
      uiNstTabItem(),
      uiActTabItem()
    )
  )
)

