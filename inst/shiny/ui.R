shinyUI(navbarPage(
    title = 'Lego Set Explorer',

    tabPanel(
        title = 'Data',
        shiny::uiOutput('table_view_columns'),
        DT::dataTableOutput('table_view')
    ),

    tabPanel(
        title = 'Desciptives',
        sidebarLayout(
            sidebarPanel(
                hr(),
                strong('Details'),
                htmlOutput('point_details')
            ),

            mainPanel(
                plotOutput("scatter_plot", click = "plot_click", height = '600px')
            )
        )
    )

))
