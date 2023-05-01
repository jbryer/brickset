shinyUI(navbarPage(
    title = 'Lego Set Explorer',

    tabPanel(
        title = 'Desciptives',
        sidebarLayout(
            sidebarPanel(
                sliderInput("bins",
                            "Number of bins:",
                            min = 1,
                            max = 50,
                            value = 30)
            ),

            mainPanel(
                plotOutput("distPlot")
            )
        )

    ),

    tabPanel(
        title = 'Data',
        shiny::uiOutput('table_view_columns'),
        shiny::dataTableOutput('table_view')
    )

))
