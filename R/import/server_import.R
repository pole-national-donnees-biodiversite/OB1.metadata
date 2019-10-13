
server_import <- function(input, output, session, savevar) {
  ns <- session$ns
  
  savevar$import <- reactiveValues()
  
  # check file import
  output$contents <- renderTable({
    
    inFile <- input$file
    
    if (is.null(inFile))
      return(NULL)
    
    print(guess_type(inFile$datapath))
    return(inFile$name)
    
  })
  
  observe({
    req(input)
    savevar$import$file <- input$file
  })
  
  # output
  return(savevar)
}
