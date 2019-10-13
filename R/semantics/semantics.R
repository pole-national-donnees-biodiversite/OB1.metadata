# semantics.R

semantics <- function(input, output, session,
                      savevar){
  ns <- session$ns
  
  # variable initialization ----
  rv <- reactiveValues(
    cur_file = isolate(savevar$import$file$name)
  )
  
  # file navigation ----
  output$current_file <- renderUI({
    req(rv$cur_file)
    rv$cur_file
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