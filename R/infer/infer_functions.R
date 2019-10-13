# infer_functions.R

mimeTypes <- unique(gsub("/.*$", "", mimemap))

inferAudio <- function(filepath, save){
  print("audio")
  # metadata <- blob_detection(filepath, metadata = TRUE)
  metadata <- threshold_detection(filepath, metadata = TRUE)
  return(metadata)
}

inferImage <- function(filepath){
  print("image")
  metadata <- exif_read(filepath)
  return(metadata)
}

inferText <- function(filepath){
  print("text")
  return("yet nothing")
}