#################################################
# Use this tab to give users instructions on use
#################################################
uiToolTabItem <- function() {
  toolTabItemResult <- tabItem(tabName = "Tool",
    fluidRow(
      box(includeMarkdown("instructions.md"),width=12)
    )
  )
  return (toolTabItemResult)
}
