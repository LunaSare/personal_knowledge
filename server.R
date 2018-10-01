server <- function(input, output) {
    # output$freq <- renderImage({
    #   # When input$n is 3, filename is ./images/image3.jpeg
    #   outfile <- normalizePath(file.path('./images',
    #                             paste0('freq.jpg')))
    #
    #
    #   # Return a list containing the filename and alt text
    #   list(src = outfile,
    #        alt = paste("Word frequency graph"))
    #
    # }, deleteFile = TRUE)
    # Warning in normalizePath(file.path("./images", paste0("freq.jpg"))) :
    #   path[1]="./images/freq.jpg": No such file or directory
    # Warning: Error in dev.off: QuartzBitmap_Output - unable to open file './images/freq.jpg'


    output$maingraph <- renderUI({
      graph <- switch(input$graphtype,
        tc = 'cloud_',
        tf = 'freq_')
      # if(myval() == 'type1')
      #   img(src='zorro.jpg', height = '300px')
      # else
        img(src = paste0(graph, abs(input$minutes), ".png"), height = '100%')
    })
    # output$freq <- renderUI({
    #   img(src='freq.png', height = '100%')
    # })
}

# shinyApp(ui, server)  # this is not needed if we have two different files with server and ui
