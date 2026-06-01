library(shiny)
library(qtlcharts)
library(broman)

data(grav)
grav <- est.rf(grav)

ui <- fluidPage(
  titlePanel("R/qtlcharts iplotRF"),
  sidebarLayout(
    sidebarPanel(
      selectInput("chr", "chromosome:", choices=c("all", chrnames(grav)))
    ),
    mainPanel(iplotRF_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list( chr=if(input$chr=="all") NULL else input$chr))

    output$plot <- iplotRF_render( iplotRF(grav, chr=dataset()$chr) )

}



shinyApp(ui, server)
