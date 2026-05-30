library(shiny)
library(qtlcharts)
library(broman)

ui <- fluidPage(
  titlePanel("R/qtlcharts iplot"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "sample size:", min=1, max=1000, value=50),
      sliderInput("cor", "Correlation::", min=-1, max=1, value=0, step=0.05)
    ),
    mainPanel(iplot_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( broman::rmvn(input$n, c(0,0), cbind(c(1, input$cor), c(input$cor, 1))) )

    output$plot <- iplot_render( iplot(dataset()[,1], dataset()[,2]) )

}



shinyApp(ui, server)
