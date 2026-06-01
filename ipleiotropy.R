library(shiny)
library(qtlcharts)
library(broman)

data(fake.bc)
fake.bc <- fake.bc[c(2,5),]
fake.bc <- calc.genoprob(fake.bc, step=1)
out <- scanone(fake.bc, method="em", phe=1:2)

ui <- fluidPage(
  titlePanel("R/qtlcharts ipleiotropy"),
  sidebarLayout(
    sidebarPanel(
      selectInput("chr", "Chromosome:", choices=chrnames(fake.bc))
    ),
    mainPanel(ipleiotropy_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(chr=input$chr) )

    output$plot <- ipleiotropy_render( ipleiotropy(fake.bc, out, chr=dataset()$chr) )

}



shinyApp(ui, server)
