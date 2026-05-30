library(shiny)
library(qtlcharts)

ui <- fluidPage(
  titlePanel("R/qtlcharts"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "sample size:", min=1, max=1000, value=10),
      sliderInput("eff", "Effect:", min=-10, max=10, value=2, step=0.05)
    ),
    mainPanel(idotplot_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( {
        x <- rnorm(input$n, 0, 1)
        y <- rnorm(input$n, input$eff, 1)
        data.frame(value=c(x,y), group=rep(1:2, rep(input$n, 2))) })

    output$plot <- idotplot_render( idotplot(dataset()$group, dataset()$value) )

}



shinyApp(ui, server)
