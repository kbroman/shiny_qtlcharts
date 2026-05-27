library(shiny)
library(qtlcharts)
library(broman)

data(fake.bc)
fake.bc <- calc.genoprob(fake.bc, step=1)
out <- scanone(fake.bc, phe=1:2, method="em")

ui <- fluidPage(
  titlePanel("R/qtlcharts"),
  sidebarLayout(
    sidebarPanel(
      selectInput("lodcolumn", "phenotype:", choices=colnames(out)[3:4]),
      selectInput("chr", "chromosome:", choices=c("all", chrnames(fake.bc)))
    ),
    mainPanel(iplotScanone_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(lodcolumn=match(input$lodcolumn, colnames(out)[3:4]),
                              chr=if(input$chr=="all") NULL else input$chr))

    output$plot <- iplotScanone_render( iplotScanone(out, fake.bc,
                                                     lodcolumn=dataset()$lodcolumn,
                                                     pheno.col=dataset()$lodcolumn,
                                                     chr=dataset()$chr) )

}



shinyApp(ui, server)
