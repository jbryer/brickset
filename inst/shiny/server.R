function(input, output, session) {
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

    output$table_view <- shiny::renderDataTable({
        legosets |>
            select(input$view_cols)
    })

    output$table_view_columns <- shiny::renderUI({
        shiny::selectInput(
            inputId = 'view_cols',
            label = 'Columns:',
            choices = names(legosets),
            selected = default_view_cols,
            multiple = TRUE,
            width = '100%'
        )
    })

}
