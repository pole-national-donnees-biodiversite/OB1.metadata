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
    req(savevar$import$file)
    HTML("<b>File:</b> ",savevar$import$file$name)
  })
  output$current_att <- renderUI({
    req(savevar$infer$metadata)
    termlist <- unlist(savevar$infer$metadata)
    termlist <- gsub(".*\\.","",names(termlist))
    termlist <- unique(gsub("[0-9]*$","",termlist))
    selectInput(ns("select_att"),
                "Select the wanted metadata term",
                termlist)
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