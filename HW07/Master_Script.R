library('rmarkdown')
setwd("~/myrepositories/STAT545-hw-Hall-Shirlett/HW07")
source("STAT545-HW07-Step1.R", local=TRUE)
rmarkdown::render("STAT545-HW07-Step1.R", knit_root_dir=NULL, clean=FALSE, envir = new.env())


source("STAT545-HW07-Step2.R", local=TRUE)
rmarkdown::render("STAT545-HW07-Step2.R", knit_root_dir=NULL, clean=FALSE, envir = new.env())
shiny_prerendered_clean('Master_Script.R')


source("STAT545-HW07-Step3.R", local=TRUE)
rmarkdown::render("STAT545-HW07-Step3.R", knit_root_dir=NULL, clean=FALSE, envir = new.env())
shiny_prerendered_clean('Master_Script.R')
rm(list=ls())


