library(shiny)
library(qtlcharts)
library(broman)

data(grav)
grav <- calc.genoprob(grav, step=0)
out <- scantwo(grav, phe="T314", method="hk", verbose=FALSE)

ui <- fluidPage(
  titlePanel("R/qtlcharts iplotScantwo"),
  sidebarLayout(
    sidebarPanel(
      selectInput("chr", "chromosome:", choices=c("all", chrnames(grav)))
    ),
    mainPanel(iplotScantwo_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list( chr=if(input$chr=="all") NULL else input$chr))

    output$plot <- iplotScantwo_render( iplotScantwo(out, grav,
                                                     pheno.col="T314",
                                                     chr=dataset()$chr) )

}



shinyApp(ui, server)
