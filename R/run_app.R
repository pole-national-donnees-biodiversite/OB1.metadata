#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
rm(list=ls())

# imports
toLoad <- c(
  "shiny",
  "shinydashboard",
  "shinyjs",
  "ontologyIndex",
  "mime",
  "datapackage.r",
  "bioacoustics",
  "exiftoolr"
)
sapply(toLoad, function(lib){
  if(!(lib %in% installed.packages()[,"Package"])){
    install.packages(lib)
    if(lib == "exiftoolr")
      install_exiftool()
  }
})
library(shinydashboard)
library(shinyjs)
library(ontologyIndex)
library(mime)
library(datapackage.r)
library(bioacoustics)

# sources

source("import/ui_import.R")
source("infer/inferUI.R")
source("semantics/semanticsUI.R")

# options 
options(shiny.reactlog = TRUE)

#run shiny app
runApp(".")