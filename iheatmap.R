library(shiny)
library(qtlcharts)
library(broman)

data(grav)
phe <- grav$pheno
o <- order(rowMeans(grav$pheno))



ui <- fluidPage(
  titlePanel("R/qtlcharts iheatmap"),
  sidebarLayout(
    sidebarPanel(
          radioButtons(inputId="sort", label="Sort rows", choices=list("Yes"=TRUE, "No"=FALSE))
    ),
    mainPanel(iheatmap_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( list(sort=input$sort) )

    output$plot <- iheatmap_render( { if(dataset()$sort) oo <- o else oo <- 1:nrow(phe)
                                         iheatmap(phe[oo,], y=seq(0, 8, len=ncol(phe)),
                                                  chartOpts=list(zlim=c(min(phe), median(unlist(phe)), max(phe)))) })

}



shinyApp(ui, server)
