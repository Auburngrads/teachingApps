
server = function(input, output, session) {

    output$armadillo_overview <- renderUI({ nestRmd('overview.Rmd')  })
teachingApps::nestServer('acceptance_testing_mtbf', envir = environment())
    
    output$examplemtbf    <- renderUI({ nestRmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ nestRmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ nestRmd('about.Rmd')      })
}
