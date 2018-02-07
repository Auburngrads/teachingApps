ui = fluidPage(theme = add_theme(getShinyOption('theme')), 
               add_css(),
               
 sidebarLayout( 
   sidebarPanel(width = 5,
     selectInput('input1',
                 label = colnames(mtcars)[2],
                 choices = unique(mtcars[,2]),
                 selected = mtcars[1,2]),
     selectInput('input2',
                 label = colnames(mtcars)[3],
                 choices = unique(mtcars[,3]),
                 selected = mtcars[1,3])),
                 
   mainPanel(plotOutput("regress"), width = 7)))
