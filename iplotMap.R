library(shiny)
library(qtlcharts)

library(qtl2)
iron <- read_cross2(system.file("extdata/iron.zip", package="qtl2"))

ui <- fluidPage(
  titlePanel("R/qtlcharts iplotMap"),
  sidebarLayout(
    sidebarPanel(
          radioButtons(inputId="map", label="Which map?", choices=list("physical"="pmap", "genetic"="gmap"))
    ),
    mainPanel(iplotMap_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( { if(input$map=="pmap") list(map=iron$pmap, ylab="Position (Mbp)") else list(map=iron$gmap, ylab="Position (cM)") })

    output$plot <- iplotMap_render( iplotMap(dataset()$map, chartOpts=list(ylab=dataset()$ylab)))

}



shinyApp(ui, server)
