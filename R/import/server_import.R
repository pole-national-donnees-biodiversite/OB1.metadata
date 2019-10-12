
server_import <- function(input, output, session, savevar) {
  ns <- session$ns
  
  print("out")
  
  # List the first level callModules here
  output$contents <- renderTable({
    print("in")

    inFile <- input$file1
    
    inFile
  })
  
  return(savevar)
}
