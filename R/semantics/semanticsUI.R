# semanticsUI.R

source("semantics/semantics.R")
source("semantics/semantics_functions.R")

# UI
semanticsUI <- function(id){
  ns <- NS(id)
  
  return(
    fluidPage(
      h1("Controlled vocabulary"),
      # file navigation
      fluidRow(
        actionButton("file_prev", "Previous"),
        uiOutput(ns("current_file")),
        actionButton("file_next", "Next")
      ),
      # fields annotation
      fluidRow(
        selectInput(ns("ontology"),
                    "Choose your ontology",
                    ontoDF$name),
        uiOutput(ns("select_term"))
      )
    )
  )
}