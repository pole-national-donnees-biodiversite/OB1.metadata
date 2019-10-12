# inferUI.R

source("infer/infer.R")
source("infer/infer_functions.R")

# UI
inferUI <- function(id){
  ns <- NS(id)
  
  return(
    fluidPage(
      h1("Metadata inference")
    )
  )
}