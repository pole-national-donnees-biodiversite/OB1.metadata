#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# imports
toLoad <- c(
  "shiny",
  "shinydashboard",
  "ontologyIndex"
)
sapply(toLoad, function(lib){
  if(!(lib %in% installed.packages()[,"Package"]))
    install.packages(lib)
})
library(shinydashboard)
library(ontologyIndex)

# sources

source("import/ui_import.R")
source("semantics/semanticsUI.R")

# options 
options(shiny.reactlog = TRUE)

#run shiny app
runApp(".")