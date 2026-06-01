library(shiny)
library(qtlcharts)

data(grav)
phe <- grav$pheno[,seq(1, nphe(grav), by=5)]
np <- ncol(phe)
scat1 <- matrix(ncol=3, nrow=choose(np, 2))
dimnames(scat1) <- list(1:nrow(scat1), c("time_diff", "pearson", "spearman"))
scat2 <- vector("list", choose(np, 2))
k <- 1
for(i in 1:(np-1)) {
    for(j in (i+1):np) {
        scat1[k,] <- c(abs(i-j), cor(phe[,i], phe[,j]), cor(phe[,i], phe[,j], method="spearman"))
        scat2[[k]] <- phe[,c(i,j)]
        rownames(scat1)[k] <- paste0(colnames(phe)[i], ":", colnames(phe)[j])
        k <- k+1
    }
}

ui <- fluidPage(
  titlePanel("R/qtlcharts scat2scat"),
  sidebarLayout(
      sidebarPanel(
          radioButtons(inputId="method", label="Correlation Method", choices=list("Pearson"="pearson", "Spearman"="spearman"))
    ),
    mainPanel(scat2scat_output("plot"))
  )
)
server <- function(input, output, session) {
    dataset <- reactive( if(input$method=="pearson") scat1[,1:2] else scat1[,c(1,3)] )

    output$plot <- scat2scat_render( scat2scat(dataset(), scat2) )

}


shinyApp(ui, server)
