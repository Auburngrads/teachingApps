library(teachingApps)
library('scales')
library(knitr)

shinyApp(options = list(height = "800px"),
         onStart = function() { options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))},
         
ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Maximum Likelihood',
                theme = shinythemes::shinytheme(theme = source('args.R')[[1]]$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(source('args.R')[[1]]$appName)),

tabPanel(h4('Background'),
         fluidRow(uiOutput('mleback1'), class = 'shiny-text-output')),

tabPanel(h4('Simple Example'),  
         fluidRow(uiOutput('example1_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::insertUI('likelihood_ace')),
         fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::insertUI('likelihood_ace2')),
         fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),

tabPanel(h4('Silly Example'),
         fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::insertUI('exp_mle')),
         fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::insertUI('exp_numerical')),
         fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
         fluidRow(teachingApps::insertUI('soln_numerical2'))),

tabPanel(h4("A Simulation"),
         fluidRow(teachingApps:::insertUI('maximum_likelihood'))),

tabPanel(h4('Details'),
         fluidRow(uiOutput('details'), class = 'shiny-text-output'))),

server = function(input, output, session) {

output$mleback1 <- renderUI({ teachingApps::insertRmd('background1.Rmd') })

output$example1_1 <- renderUI({ teachingApps::insertRmd('example1_1.Rmd') })
  teachingApps::insertServer('likelihood_ace', envir = environment())
output$example1_2 <- renderUI({ teachingApps::insertRmd('example1_2.Rmd') })
  teachingApps::insertServer('likelihood_ace2', envir = environment())
output$example1_3 <- renderUI({ teachingApps::insertRmd('example1_3.Rmd') })


output$example2_1 <- renderUI({ teachingApps::insertRmd('example2_1.Rmd') })
  teachingApps::insertServer('exp_mle', envir = environment())
output$example2_2 <- renderUI({ teachingApps::insertRmd('example2_2.Rmd') })
  teachingApps::insertServer('exp_numerical', envir = environment())
output$example2_3 <- renderUI({ teachingApps::insertRmd('example2_3.Rmd') })
  teachingApps::insertServer('soln_numerical2', envir = environment())

  
## SERVER FOR SIMULATION
teachingApps:::insertServer('maximum_likelihood', envir = environment())


output$details <- renderUI({ teachingApps::insertRmd('details.Rmd') })
})
