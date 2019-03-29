library(devtools)
library(roxygen2)
library(usethis)

#usethis::create_package("/home/rstudio/src/packages/","model")
#go back to folder we started
file_path <- "/home/rstudio"
tmp <- file.path(file_path, "model1")
create_package(tmp)


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

file.copy(from="/home/rstudio/src/model/ModelWithDoc.R", to="/home/rstudio/model1/R/",overwrite = TRUE,copy.mode = TRUE)
file.copy(from="/home/rstudio/packages/Version.txt", to="/home/rstudio/model1",overwrite = TRUE,copy.mode = TRUE)
updatePkgVer('/home/rstudio/model1')
#document()

dir.create('/work/work_model',mode='0777')
list_of_files <- list.files('/home/rstudio/model1/')
file.copy(file.path('/home/rstudio/model1/',list_of_files),'/work/work_model/' )
dir.create('/work/work_model/man',mode='0777')
dir.create('/work/work_model/R',mode='0777')
list_of_files_man <- list.files('/home/rstudio/model1/man/')
list_of_files_R <- list.files('/home/rstudio/model1/R/')
file.copy(file.path('/home/rstudio/model1/man/',list_of_files_man),'/work/work_model/man/' )
file.copy(file.path('/home/rstudio/model1/R/',list_of_files_R),'/work/work_model/R/' )
