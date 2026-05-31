library(shiny)
library(qtlcharts)

data(geneExpr)

corp <- cor(geneExpr$expr, use="pairwise.complete.obs")
op <- hclust(as.dist(1-corp))$order

cors <- cor(geneExpr$expr, method="spearman", use="pairwise.complete.obs")
os <- hclust(as.dist(1-cors))$order


ui <- fluidPage(
  titlePanel("R/qtlcharts iplotCorr"),
  sidebarLayout(
      sidebarPanel(
          radioButtons(inputId="method", label="Correlation Method", choices=list("Pearson"="pearson", "Spearman"="spearman"))
    ),
    mainPanel(iplotCorr_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( if(input$method=="pearson") list(expr=geneExpr$expr[,op], cor=corp[op, op]) else list(expr=geneExpr$expr[,os], cor=cors[os,os]) )

    output$plot <- iplotCorr_render( iplotCorr(dataset()$expr, group=geneExpr$genotype, corr=dataset()$cor) )

}


shinyApp(ui, server)
