
server = function(input, output, session) {

<<<<<<< HEAD
    output$armadillo_overview <- renderUI({ add_rmd('overview.Rmd')  })
     add_server('acceptance_testing_mtbf', env = environment())
    
    output$examplemtbf    <- renderUI({ add_rmd('example.Rmd')    })
    output$backgroundmtbf <- renderUI({ add_rmd('background.Rmd') })
    output$aboutmtbf      <- renderUI({ add_rmd('about.Rmd')      })
=======
    add_server(path = dirs[1] , env = environment())
    add_server(path = dirs[2] , env = environment())
    add_server(path = dirs[4] , env = environment())
    add_server(path = dirs[5] , env = environment())
    add_server(path = dirs[9] , env = environment())
    add_server(path = dirs[10], env = environment())
    add_server(path = dirs[11], env = environment())
>>>>>>> 725cde6e3cf3d4f401624356a8d30a138358fcc1
}
