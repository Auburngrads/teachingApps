library(teachingApps)
library(scales)
library(metricsgraphics)
library(SMRD)
library(DT)
options('markdown.HTML.stylesheet' = system.file('css','my-shiny.css', package = 'teachingApps'))

ui = navbarPage(collapsible = T, 
                position = 'fixed-top',
                title = 'Complex Ideas',
                theme = shinythemes::shinytheme(theme = global$theme),
                header = tags$head(includeCSS(system.file('css', 'my-shiny.css', package = 'teachingApps'))),
                footer = HTML(teachingApps::teachingApp(global$appName)),
                
tabPanel(h4("Conf. Intervals"),
         fluidRow(teachingApps::insertUI('confidence_intervals'))),

tabPanel(h4("CLT"),
         fluidRow(teachingApps::insertUI('central_limit'))),

tabPanel(h4("Prob Plots"),
         fluidRow(teachingApps::insertUI('probability_plotting'))),

tabPanel(h4("Weibull Distro"),
         fluidRow(teachingApps::insertUI('distribution_weibull'))),

tabPanel(h4("ML Estimation"),
         fluidRow(teachingApps::insertUI('maximum_likelihood'))),

tabPanel(h4('Dice Roll'),
         fluidRow(teachingApps::insertUI('dice_roll'))))