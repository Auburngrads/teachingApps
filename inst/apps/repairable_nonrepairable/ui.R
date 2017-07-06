ui = navbarPage(title = 'System Reliability',
                collapsible = T, 
                position = 'fixed-top',
                theme  = add_theme(getShinyOption('theme')),
                header = add_css(),
                footer = add_logo(),

                
tabPanel("Repairable Systems",
fluidRow(column(width = 12,
         uiOutput('reptext', class = 'ta-text', width = '100%'))),

fluidRow(column(width = 5,
    sidebarPanel(width = '100%',
      shinyAce::aceEditor(fontSize = 16,
                          wordWrap = T,
                          outputId = "repplot",
                          mode = "r",
                          theme = "github",
                          height = "475px",
                          value = 
"DiffMat <- matrix(NA, nrow = 4, ncol = 4)

AA <- as.data.frame(DiffMat)
AA[[1,2]] <- 'F[1:0]'
AA[[1,3]] <- 'F[2:0]'
AA[[2,1]] <- 'F[0:1]'
AA[[3,1]] <- 'F[0:2]'
AA[[4,1]] <- 'F[0:3]'

name <- c(expression(0[Alive]), 
          expression(1[Failed]), 
          expression(2[Failed]), 
          expression(3[Dead]))

par(family='serif', mar = c(0,0,0,0))

diagram::plotmat(A = AA, pos = 4, curve = .575, 
         name = name, lwd = 2, arr.len = 0.6, 
         arr.width = 0.25, my = .15, box.size = 0.08, 
         arr.type = 'triangle', dtext = -1,
         relsize=.99, box.cex=1.5, cex=1.25)"),

        actionButton("evalrep", "Evaluate"))),

        column(width = 7, plotOutput("plotrep", height = "600px")))),

tabPanel("Nonrepairable Systems",
fluidRow(column(width = 12,
      uiOutput('noreptext', class = 'ta-text', width = '100%'))),

fluidRow(column(width = 5,
    sidebarPanel(width = '100%',
      shinyAce::aceEditor(fontSize = 16,
                          wordWrap = T,
                          outputId = "norepplot",
                          mode = "r",
                          theme = "github",
                          height = "475px",
                          value = 
"Mat1 <- matrix(NA, nrow = 3, ncol = 3)

AA <- as.data.frame(Mat1)
AA[[2,1]] <- 'F[0:1]'
AA[[3,1]] <- 'F[0:2]'

name <- c(expression(0[Alive]), 
          expression(1[Dead]), 
          expression(2[Dead]))

par(family='serif')

diagram::plotmat(A = AA, pos = 3, curve = .575, 
         name = name, lwd = 2, arr.len = 0.6, 
         arr.width = 0.25, my = .25, box.size = 0.08, 
         arr.type = 'triangle', dtext = -1,
         relsize=.99, box.cex=1.5, cex=1.25)"),

        actionButton("evalnorep", "Evaluate"))),

        column(width = 7, plotOutput("plotnorep", height = "600px")))))
