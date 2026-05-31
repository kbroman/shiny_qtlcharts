library(shiny)
library(qtlcharts)
library(broman)
library(qtl)

data(hyper)
hyper$pheno$sqrt_bp <- sqrt(hyper$pheno[,1])

markers <- markernames(hyper)
phe <- c("bp", "sqrt_bp")

ui <- fluidPage(
  titlePanel("R/qtlcharts iplotPXG"),
  sidebarLayout(
    sidebarPanel(
        selectInput("marker", "marker:", choices=markers, selected="D4Mit214"),
        selectInput("phenotype", "phenotype:", choices=phe)
    ),
    mainPanel(idotplot_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(marker=input$marker, phenotype=input$phenotype) )

    output$plot <- idotplot_render( iplotPXG(hyper, marker=dataset()$marker,
                                             pheno.col=dataset()$phenotype) )

}


shinyApp(ui, server)
