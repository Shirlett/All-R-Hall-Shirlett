#' ---
#' title: Report of Exploration into UN Data and Worldwide Internet Usage - Part 2
#' author: Shirlett Hall
#' date: November 14, 2017
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#'    github_document: 
#'      toc: true
#' ---

options(warn = -1)
options(message = -1)
suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(gridExtra)))
suppressWarnings(suppressMessages(library(scales)))
suppressWarnings(suppressMessages(library(maps)))
suppressWarnings(suppressMessages(library(maptools)))

setwd("~/myrepositories/STAT545-hw-Hall-Shirlett/HW07")
library('tidyverse')
library(knitr) 
#' for formatting the output of tables
library(dplyr) 
#' for grouping and filtering
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
library(stringr) #for replacement of strings in dataset columns
library(broom) # to tidy printed summary output and convert to a dataframe
library(gridExtra) #used to layout tables and charts in a grid
library(grid) #used to layout tables and charts in a grid
setwd("~/myrepositories/STAT545-hw-Hall-Shirlett/HW07")




#' #Statistical Analysis and Figures
library(readr)
All_Data <- read_csv("./All_Data.csv")


#' Get median values for number of Internet Users and Urban Density
Internet_Urban <- All_Data %>%
	select(Year, Internet_Users_per_100, Percent_urban) %>%
	group_by(Year) %>%
	summarise(Med_Internet_Users=median(Internet_Users_per_100), Med_Percent_urban=median(Percent_urban, na.rm = TRUE)) 

#' Get estimate of slopes, intercepts for linear model
urbanfit <- tidy(lm(Med_Internet_Users ~ Med_Percent_urban, data = Internet_Urban))
kable(urbanfit)

#' Capture p-value to pass to graph
pval <- toString(round(urbanfit[2,5], digits=5))


#' #Linear Regression
Urban_plot <- Internet_Urban %>%
	ggplot(aes(Med_Percent_urban, Med_Internet_Users)) +
	geom_point(shape=1) + 
	geom_smooth(method=lm) +
	labs( 
		subtitle="Internet Usage as influenced by Urban Density, 2008-15", 
		caption="source: UN",
		y = "Median Number of Internet Users per 100 inhabitants per Year", x= "Median Percent of Populations living in Urban Areas") +
	theme(plot.subtitle = element_text(size = 15)) +
	annotate("text", x=65, y=10, label = paste("p-value=", pval), parse=F) 

ggsave("./img/Urban_plot.png", Urban_plot, width = 14, height=15, units="cm", scale=1)

#' The graph below shows that there is a positive relationship between Internet usage and urban density.
#' With a value less than 0.05, the p-value also indicates that this relationship is significant.

#' ![See Resulting Plot in PNG Format](./img/Urban_plot.png)

#' Get median values for number of Internet Users and Gross National Income
Internet_GNI <- All_Data %>%
	select(Year, Internet_Users_per_100, GNI_per_cap) %>%
	group_by(Year) %>%
	summarise(Med_Internet_Users=median(Internet_Users_per_100), Med_GNI=median(GNI_per_cap, na.rm = TRUE)) 

#' Get estimate of slopes, intercepts for linear model
gnifit <- tidy(lm(Med_Internet_Users ~ Med_GNI, data = Internet_GNI))
kable(gnifit)

#' Capture p-value to pass to graph
pgni <- toString(round(gnifit[2,5], digits=5))


#' Linear Regression
GNI_plot <- Internet_GNI %>%
	ggplot(aes(Med_GNI, Med_Internet_Users)) +
	geom_point(shape=1) + 
	geom_smooth(method=lm) +
	labs(
		subtitle="Internet Usage as influenced by Gross National Income, 2008-15", 
		caption="source: UN",
		y = "Median Number of Internet Users per 100 inhabitants per Year", x= "Median Gross National Income per Capita") +
	theme(plot.subtitle = element_text(size = 15)) +
	annotate("text", x=5900, y=10, label = paste("p-value=", pgni), parse=F) 


ggsave("./img/GNI_plot.png", GNI_plot, width = 14, height=15, units="cm", scale=1)

#' The graph below shows that there is a positive relationship between Internet usage and GNI.
#' With a value less than 0.05, the p-value also indicates that this relationship is significant.

#' ![See Resulting Plot in PNG Format](./img/GNI_plot.png)


#' Get median values for number of Internet Users and Access to Electricity
Internet_Electricity <- All_Data %>%
	select(Year, Internet_Users_per_100, Per_Access_Electricity) %>%
	group_by(Year) %>%
	summarise(Med_Internet_Users=median(Internet_Users_per_100), Med_Percent_Electricity=median(Per_Access_Electricity, na.rm = TRUE)) 

#' Get estimate of slopes, intercepts for linear model using the broom package to present results
electfit <- tidy(lm(Med_Internet_Users ~ Med_Percent_Electricity, data = Internet_Electricity))
kable(electfit)

#' Capture p-value to pass to graph
pelec <- toString(round(electfit[2,5], digits=5))

#' Linear Regression
Elect_plot <- Internet_Electricity %>%
	ggplot(aes(Med_Percent_Electricity, Med_Internet_Users)) +
	geom_point(shape=1) + 
	geom_smooth(method=lm) +
	labs( 
		subtitle="Internet Usage as influenced by Access to Electricity, 2008-15", 
		caption="source: UN",
		y = "Median Number of Internet Users per 100 inhabitants per Year", x= "Median Percent of Populations with Access to Electricity") +
	theme(plot.subtitle = element_text(size = 15)) +
	annotate("text", x=99, y=10, label = paste("p-value=", pelec), parse=F) 


ggsave("./img/Elect_plot.png", Elect_plot, width = 14, height=15, units="cm", scale=1)

#' The graph below shows that there is a positive relationship between Internet usage and the
#' percentage of persons with access to elecricity.
#' With a value less than 0.05, the p-value also indicates that this relationship is significant.

#' ![See Resulting Plot in PNG Format](./img/Elect_plot.png)


#' Get median values for number of Internet Users and Life Expectancy
Internet_Life <- All_Data %>%
	select(Year, Internet_Users_per_100, Median_Life_Exp) %>%
	group_by(Year) %>%
	summarise(Med_Internet_Users=median(Internet_Users_per_100), Med_Life=median(Median_Life_Exp, na.rm = TRUE)) 

#' Get estimate of slopes, intercepts for linear model
lifefit <- tidy(lm(Med_Internet_Users ~ Med_Life, data = Internet_Life))
kable(lifefit)

#' Capture p-value to pass to graph
plife <- toString(round(lifefit[2,5], digits=5))


#' Linear Regression
Life_plot <- Internet_Life %>%
	ggplot(aes(Med_Life, Med_Internet_Users)) +
	geom_point(shape=1) + 
	geom_smooth(method=lm) +
	labs( 
		subtitle="Internet Usage as influenced by Life Expectancy, 2008-15", 
		caption="source: UN",
		y = "Median Number of Internet Users per 100 inhabitants per Year", x= "Median Life Expectancy") +
	theme(plot.subtitle = element_text(size = 15)) +
	annotate("text", x=73, y=10, label = paste("p-value=", plife), parse=F) 


ggsave("./img/Life_plot.png", Life_plot, width = 14, height=15, units="cm", scale=1)

#' The graph below shows that there is a positive relationship between Internet usage and median
#' life expectancy.
#' With a value less than 0.05, the p-value also indicates that this relationship is significant.
#' Of all the four factors, this relationship has the lowest p-value and will be expanded in Part 3.

#' ![See Resulting Plot in PNG Format](./img/Life_plot.png)

#+ fig.height=40, fig.width=28

#Arrange the figures in a grid
internet_grid <- grid.arrange(Urban_plot, GNI_plot, Elect_plot, Life_plot,
															ncol=2,
															as.table=TRUE,
															heights=c(15,15),
															widths=c(13, 13),
															top="Linear Regression")

ggsave("./img/internet_grid.png", internet_grid, width = 28, height=40, units="cm", scale=1)
