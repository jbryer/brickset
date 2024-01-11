function(input, output, session) {
    output$scatter_plot <- renderPlot({
        legosets |>
            dplyr::select(pieces, US_retailPrice, minifigs, themeGroup) |>
            dplyr::mutate(minifigs = ifelse(is.na(minifigs), 0, minifigs)) |>
            tidyr::drop_na(US_retailPrice, pieces) |>
            ggplot(aes(x = pieces, y = US_retailPrice)) +
            geom_point(aes(size = minifigs + 1),
                       alpha = 0.75, shape = 21, fill = 'grey90') +
            geom_smooth(method = 'lm', formula = y ~ x) +
            scale_size('Number of\nMinifigs') +
            xlab('Number of Lego Pieces') + ylab('US Retail Price')

    })

    output$point_details <- renderText({
        html <- ''
        row <- nearPoints(legosets, input$plot_click)
        if(nrow(row) > 0) {
            html <- paste0('<img src="', row[1,]$thumbnailURL, '" />')
        }
        return(html)
    })

    output$table_view <- DT::renderDataTable({
        legosets |>
            mutate_at(c('theme','themeGroup','subtheme','category',
                        'packagingType','availability'),
                      as.factor) |>
            select(input$view_cols) |>
            DT::datatable(
                rownames = FALSE,
                filter = 'top',
                options = list(
                    pageLength = 20
                ),
                selection = 'single'
            )
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
