library(shiny)
library(qtlcharts)
library(broman)
library(qtl2)

phe <- read_cross2(system.file("extdata/grav2.zip", package="qtl2"))$pheno
ti <- as.numeric(sub("T", "", colnames(phe)))


ui <- fluidPage(
  titlePanel("R/qtlcharts iplotCurves"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("time1", "Time 1:", min=min(ti), max=max(ti), value=0, step=diff(ti[1:2])),
      sliderInput("time2", "Time 2:", min=min(ti), max=max(ti), value=240, step=diff(ti[1:2])),
      sliderInput("time3", "Time 3:", min=min(ti), max=max(ti), value=480, step=diff(ti[1:2]))
    ),
    mainPanel(iplotCurves_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(time1=which.min(abs(ti-input$time1)),
                              time2=which.min(abs(ti-input$time2)),
                              time3=which.min(abs(ti-input$time3)) ) )

    output$plot <- iplotCurves_render( iplotCurves(phe, ti,
                                                   phe[,c(dataset()$time1, dataset()$time2)],
                                                   phe[,c(dataset()$time2, dataset()$time3)]) )


}



shinyApp(ui, server)
