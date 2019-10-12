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
  if(!(lib %in% installed.packages()[,"Package"]))
    install.packages(lib)
  library(lib)
})
# library(shinydashboard)
# library(ontologyIndex)

# sources

source("import/ui_import.R")
source("semantics/semanticsUI.R")

#run shiny app
runApp(".")