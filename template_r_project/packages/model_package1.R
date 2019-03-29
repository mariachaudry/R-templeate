updatePkgVer <- function(packageLocation ="."){
  ## Read DESCRIPTION file
  desc <- readLines(file.path(packageLocation, "DESCRIPTION"))
  ver_num <- readLines(file.path(packageLocation, "Version.txt"))

  ## Find the line where the version is defined
  vLine <- grep("^Version\\:", desc)

  ## Split the version number into two; a piece to keep, a piece to increment
  versionNumber <- strsplit(ver_num, "\\.")[[1]]
  versionParts <- length(versionNumber)
  vNumberKeep <- paste(versionNumber[1:(versionParts-1)], sep= "", collapse= ".")
  vNumberUpdate <- versionNumber[versionParts]

  ## Build final version number
  vFinal <- paste(vNumberKeep, vNumberUpdate, sep = ".")

  ## Update DESCRIPTION file (in R)
  desc[vLine] <- paste0("Version: ", vFinal )

  ## Update the actual DESCRIPTION file
  writeLines(desc, file.path(packageLocation, "DESCRIPTION"))

  ## Return the updated version number to screen
  return(vFinal)
}

library(devtools)
library(roxygen2)

file.copy(from="/work/template_r_project/src/model/ModelWithDoc.R", to="/work/model1/R/",overwrite = TRUE,copy.mode = TRUE)
file.copy(from="/work/template_r_project/src/packages/Version.txt", to="//work/model1",overwrite = TRUE,copy.mode = TRUE)
updatePkgVer('/work/model1')
document()
