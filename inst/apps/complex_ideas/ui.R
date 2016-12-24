library(teachingApps)
library(scales)
library(metricsgraphics)
library(SMRD)
library(DT)


ui = navbarPage(title = 'Complex Ideas',
                collapsible = T, 
                position = 'fixed-top',
                theme = shinythemes::shinytheme(theme = getShinyOption("theme")),
                header = tags$head(includeCSS(getShinyOption("css"))),
                footer = HTML(teachingApps::teachingApp(getShinyOption("appName"))),
                
tabPanel(h4("Conf. Intervals"),
         fluidRow(teachingApps::nestUI('confidence_intervals'))),

tabPanel(h4("CLT"),
         fluidRow(teachingApps::nestUI('central_limit'))),

tabPanel(h4("Prob Plots"),
         fluidRow(teachingApps::nestUI('probability_plotting'))),

tabPanel(h4("Weibull Distro"),
         fluidRow(teachingApps::nestUI('distribution_weibull'))),

tabPanel(h4("ML Estimation"),
         fluidRow(teachingApps::nestUI('maximum_likelihood'))),

tabPanel(h4('Dice Roll'),
         fluidRow(teachingApps::nestUI('dice_roll'))))