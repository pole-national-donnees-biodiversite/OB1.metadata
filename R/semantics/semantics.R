# semantics.R

semantics <- function(input, output, session,
                      savevar){
  ns <- session$ns
  
  # variable initialization ----
  rv <- reactiveValues(
    files_names = c("file1", "file2"),
    cur_file = 1
  )
  
  # file navigation ----
  output$current_file <- renderUI({
    req(rv$cur_file)
    rv$files_names[rv$cur_file]
  })
  observeEvent(input$file_next,{
    req(rv$cur_file)
    if(rv$cur_file < length(rv$files_names))
      rv$cur_file <- rv$cur_file+1
  })
  observeEvent(input$file_prev,{
    req(rv$cur_file)
    if(rv$cur_file > 0)
      rv$cur_file <- rv$cur_file-1
  })
  
  # fields annotation ----
  output$select_term <- renderUI({
    # browser()
    onto <- get_ontology(ontoDF[
      ontoDF$name == input$ontology,
      "path"
    ])
    terms <- gsub("^[[:alnum:]]*_","",onto$name)
    uris <- names(onto$name)
    # out
    selectInput(ns("select_term"),
                "Choose a term",
                terms)
  })
}