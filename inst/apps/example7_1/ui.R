library(teachingApps)
library(package = 'SMRD')

ui = navbarPage(title = 'Example 7.1',
                collapsible = T, 
                position = 'fixed-top',
                theme  = teachingApps::add_themes(getShinyOption('theme')),
                header = teachingApps::add_styles(),
                footer = teachingApps::add_footer(),

                
tabPanel(h4('Background'),
         mainPanel(uiOutput('example7.1'), class = 'shiny-text-output', width = 12)),
                
tabPanel(h4("Data"), DT::dataTableOutput("berkson", height = "600px")),

navbarMenu(h4('Figures'), icon = icon('bar-chart-o'),
tabPanel(h4("Figure 7.1"),
fluidRow(column(width = 5,
    sidebarPanel(width = '100%',
      shinyAce::aceEditor(fontSize = 16,
                          wordWrap = T,
                          outputId = "fig71plot",
                          mode = "r",
                          theme = "github",
                          height = "450px",
                          value = "
sample.size <- 20

berkson <- 
switch(as.character(sample.size), 
      '20' = {SMRD::berkson20},
     '200' = {SMRD::berkson200},
    '2000' = {SMRD::berkson2000},
   '10220' = {SMRD::berkson10220})

berkson.ld <- 
frame.to.ld(berkson,
            response.column = c(1,2),
            censor.column = 3,
            case.weight.column = 4)

plot(berkson.ld, distribution = 'Exponential')"),

        actionButton("evalfig71", h4("Evaluate"), width = '100%'))),

column(width = 7, 
       mainPanel(width = '100%',plotOutput("plotfig71", height = "600px")))))))
