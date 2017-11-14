#' ---
#' title: Report of Exploration into UN Data and Worldwide Internet Usage - Part 3
#' author: Shirlett Hall
#' date: November 14, 2017
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#' ---

options(warn = -1)
options(message = -1)
suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(gridExtra)))
suppressWarnings(suppressMessages(library(scales)))
suppressWarnings(suppressMessages(library(maps)))
suppressWarnings(suppressMessages(library(maptools)))
library(dplyr) 
#' for grouping and filtering	
library(tidyverse)
library(knitr)  
#' for formatting the output of tables
library(forcats) 
#' used to manipulate factors for ordering, lumping etc
library(gridExtra) 
#' used to layout tables and charts in a grid
library(grid) 
#' used to layout tables and charts in a grid
library(readxl) 
#' used to read excel file formats
library(RColorBrewer) 
#' has a set of colors for print and graphics
library(scales) 
#' to modify the appearance of axis values and colors
library(ggthemes) 
#' additional color themes
library(devtools) 
#' used to save figures
library(ggplot2)
library(maps)
library(ggmap)
library(maptools)
library(stringr) 
#' for replacement of strings in dataset columns
library(broom) 
#' to tidy printed summary output and convert to a dataframe


setwd("~/myrepositories/STAT545-hw-Hall-Shirlett/HW07")


library(readr)
All_Data <- read_csv("./All_Data.csv")

#' #Deeper Statistical Analysis and Figures

#' Based on p-values derived for each factor across the world, Life Expectancy has the best
#' significance with Internet Usage. We can find the countries where this is the greatest
Internet_Life <- All_Data %>%
	select(Country, Year, Internet_Users_per_100, Median_Life_Exp) %>%
	drop_na(Median_Life_Exp) %>%
	group_by(Country) %>%
	do(tidy(lm(Internet_Users_per_100 ~ Median_Life_Exp, data=.))) %>%
	filter(term=="Median_Life_Exp") %>%
	tally(p.value) 

top3 <- Internet_Life %>%
	top_n(3) 
kable(top3)
#' Life expectancy has the least significance in Liechtenstein, Seychelles, and the United States.
#' This is likely because the life expectancy in these countries have been so stable between 2008 and
#' 2015, yet internet usage has increased. There are other factors influencing the increase in usage.


bottom3 <- Internet_Life %>%
	top_n(-3) 
kable(bottom3)
#' Life expectancy has the most significance in North Korea, Solomon Islands and Yemen. North Korea
#' has no record of Internet Usage so the p-value is invalid, whereas Solomon Islands and Yemen have
#' seen similar rates of change in Internet usage and life expectancy in a positive direction.


matters<- rbind(top3, bottom3) %>%
	ggplot(aes(x=reorder(Country, n), n)) + 
	geom_bar(stat="identity", width=.5, fill="tomato3") + 
	labs(title="Ordered Bar Chart - Life Expectancy vs Internet Usage", 
			 subtitle="Highest and Lowest p-values for Countries in the World", 
			 caption="source: UN",
			 y="p-values",
			 x="Country") + 
	theme(axis.text.x = element_text(angle=65, vjust=0.6))


ggsave("./img/matters.png", matters, width = 28, height=30, units="cm", scale=1)


#' ![See Resulting Plot in PNG Format](./img/matters.png)