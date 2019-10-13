# semanticsUI.R

source("semantics/semantics_functions.R")
source("semantics/semantics.R")

# UI
semanticsUI <- function(id){
  ns <- NS(id)
  
  return(
    fluidPage(
      h1("Controlled vocabulary"),
      # file navigation
      fluidRow(
        uiOutput(ns("current_file"))
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