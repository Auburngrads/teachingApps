
server = function(input, output, session) {

teachingApps::nestServer('acceptance_testing_mtbf', envir = environment())
    output$howtomtbf      <- renderUI({ nestRmd('howtomtbf.Rmd')  })
    output$examplemtbf    <- renderUI({ nestRmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ nestRmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ nestRmd('about.Rmd')      })
}
