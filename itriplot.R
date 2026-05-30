library(shiny)
library(qtlcharts)

ui <- fluidPage(
  titlePanel("R/qtlcharts itriplot"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "sample size per:", min=1, max=1000, value=50),
      sliderInput("n_draws", "number of draws:", min=1, max=1000, value=50)
    ),
    mainPanel(itriplot_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive({
        x <- t(rmultinom(input$n_draws, input$n, c(0.25, 0.5, 0.25)))
        colnames(x) <- LETTERS[1:3]
        x/rowSums(x)
    })

    output$plot <- itriplot_render( itriplot(dataset()) )


}



shinyApp(ui, server)
