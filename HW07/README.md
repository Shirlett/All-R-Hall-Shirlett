# Purpose

The overall purpose of this assignment was to explore non-Gapminder data that is related to Internet usage across the globe. It is a compilation of datasets found on the UN website which combines internet usage per 100 inhabitants in a country, along with data related to other factors that may or may not affect the levels of internet penetration. 

# Main Sections

The output of this exercise are in three parts found as follows:

![Part 1](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step1.md) introduces the Internet usage and related data and prepares the file for processing and exploration. It also provides an overview of internet usage for 203 countries across the world illustrated by a dot plot and choropleth map.

There is also an html version of the github document that can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step1.html).


![Part 2](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step2.md) performs some statistical analysis to show the relationship and correlation between internet usage and several other factors that can influence the levels. These factors include urban density, life expectancy and Gross National Income per Capita.

The html version of the file can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step2.html).


![Part 3](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step3.md) does a deeper statistical analysis based on the p-values or significance levels revealed in Part 2.

Once again the html file can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/STAT545-HW07-Step3.html).

# Reflection
Beyond the exploration of a new dataset, this exercise also allowed me to employ the use of the .R file structure and the makefile language to organize my files. I have strictly used .Rmd in the past and I had to recreate the .Rmd files to .R for this assignment. Fortunately, I discovered that the syntax was very similar and R can "spin" .Rmd looking files such that they are interpreted as .R using #' preceding YAML and typical code chunk syntax. This was a very helpful website for learning how to perform this "conversion": http://brooksandrew.github.io/simpleblog/articles/render-reports-directly-from-R-scripts/

Creating the makefile was not very complicated and another user can run the sections in the correct order by copying the R files and changing their working directory. The makefile can be viewed ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/makefile).
I also created a master script in R to render all the R files in the correct order. However, the master script creates many extra spin files during rendering and made the folder appear cluttered. The makefile seems to be superior to the master script in terms of a learning curve.

