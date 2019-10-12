#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#' Run the Shiny Application
#'
#' @export

# imports
toLoad <- c(
  "shinydashboard",
  "ontologyIndex"
)
sapply(toLoad, function(lib){
  installed.packages()
})
library(shinydashboard)
library(ontologyIndex)

# sources
source("semantics/semanticsUI.R")


#run shiny app
runApp(".")