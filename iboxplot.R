library(shiny)
library(qtlcharts)

n.ind <- 500
n.gene <- 10000
expr <- matrix(rnorm(n.ind * n.gene, (1:n.ind)/n.ind*3), ncol=n.gene)
dimnames(expr) <- list(paste0("ind", 1:n.ind),
                        paste0("gene", 1:n.gene))
expr <- expr[sample(1:n.ind),]

ui <- fluidPage(
  titlePanel("R/qtlcharts"),
  sidebarLayout(
      sidebarPanel(
          radioButtons(inputId="sort", label="Sort", choices=list("Yes"=TRUE, "No"=FALSE))
    ),
    mainPanel(iboxplot_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(sort=input$sort) )

    output$plot <- iboxplot_render( iboxplot(expr, orderByMedian=dataset()$sort) )

}


shinyApp(ui, server)
