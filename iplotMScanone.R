library(shiny)
library(qtlcharts)

data(grav)
grav$pheno <- grav$pheno[,seq(1, nphe(grav), by=5)]
grav <- calc.genoprob(grav, step=0)
out <- scanone(grav, phe=1:nphe(grav), method="hk")
times <- as.numeric(sub("T", "", phenames(grav)))/60


ui <- fluidPage(
  titlePanel("R/qtlcharts iplotMScanone"),
  sidebarLayout(
      sidebarPanel(
          radioButtons(inputId="effects", label="Show QTL effects", choices=list("Yes"=TRUE, "No"=FALSE))
    ),
    mainPanel(iplotMScanone_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( if(input$effects) grav else NULL)

    output$plot <- iplotMScanone_render( iplotMScanone(out, dataset(), times=times,
                                                       chartOpts=list(ylab="time (hrs)", eff_ylab="QTL effect")) )

}


shinyApp(ui, server)
