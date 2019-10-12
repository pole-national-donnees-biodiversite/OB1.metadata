# semantics_functions.R

library(ontologyIndex)

# list ontologies and their files
{
  # compute
  ontonames <- dir("../resources/", pattern = "\\.obo$")
  ontopath <- dir("../resources/", pattern = "\\.obo$")
  # gather
  ontoDF <- data.frame(
    name = c(
      gsub("\\..*$","",ontonames)
    ),
    path = c(
      "~/Softwares/Gits/OB1.metadata/resources/marinetlo.obo"
    ),
    stringsAsFactors = FALSE
  )
}


