library(teachingApps)
library('scales')
library(knitr)
         
ui = navbarPage(title = 'Maximum Likelihood',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                # header = list(tags$head(includeCSS(getShinyOption("CSS"))),
                #               tags$head(includeCSS("www/custom.css"))),
                # footer = HTML(teachingApps::signature(getShinyOption("appName"))),

tabPanel(h4('Background'),
         fluidRow(uiOutput('mleback1'), class = 'shiny-text-output')),

tabPanel(h4('Simple Example'),  
         fluidRow(uiOutput('example1_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::nestUI('likelihood_ace')),
         fluidRow(uiOutput('example1_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::nestUI('likelihood_ace2')),
         fluidRow(uiOutput('example1_3'), class = 'shiny-text-output')),

tabPanel(h4('Silly Example'),
         fluidRow(uiOutput('example2_1'), class = 'shiny-text-output'),
         fluidRow(teachingApps::nestUI('exp_mle')),
         fluidRow(uiOutput('example2_2'), class = 'shiny-text-output'),
         fluidRow(teachingApps::nestUI('exp_numerical')),
         fluidRow(uiOutput('example2_3'), class = 'shiny-text-output'),
         fluidRow(teachingApps::nestUI('soln_numerical2'))),

tabPanel(h4("A Simulation"),
         fluidRow(teachingApps:::nestUI('likelihood_simulation'))),

tabPanel(h4('Details'),
         fluidRow(uiOutput('details'), class = 'shiny-text-output')))
