# inferUI.R

source("infer/infer_functions.R")
source("infer/infer.R")

# UI
inferUI <- function(id){
  ns <- NS(id)
  
  return(
    fluidPage(
      h1("Metadata inference"),
      uiOutput(ns("infer_ui"))
    )
  )
}