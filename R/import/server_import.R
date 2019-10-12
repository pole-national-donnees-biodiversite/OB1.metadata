
server_import <- function(input, output, session, savevar) {
  ns <- session$ns
  
  print("out")
  
  # List the first level callModules here
  output$contents <- renderTable({
    print("in")

    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)

      df <- read.csv(inFile$datapath,
                     #header = input$header,
                     sep = input$sep
                     #quote = input$quote
                     )
      return(head(df))
    
  })
  
  return(savevar)
}
