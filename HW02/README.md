## Introduction

The results of the dplyr exploration along with the ggplots can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW02/Gapminder_Explore.md).


### Reflection

This homework was far more challenging than the first assignment because it involved the use of more complex R functions and ggplot. Prior to this class, I had never attempted to create ggplots in R. In contrast, setting up the folder in Github was a far simpler task.

One of the tasks that I found challenging was identifying the class of the gapminder object. Documentation online referred to classes as S3, S4 etc and not as tables which was the result produced by the structure (str) command. 

Another area of difficulty was related to the kable functionality. I did not get a clear understanding of how this applies and especially not to the variables I chose to explore. Instead, I found a way to produce a description of the variables in tabular format using the with and table functions.

I had an idea of the way in which I wanted to show a relationship between population growth and gdpPerCap in the most populated countries, however, I failed to overlay the gdpPercap onto the preexisting plot of population against year. There is a massive discrepancy in the scale of the two continuous variables which rendered the combined graphs nonsensical. The compromise was to use geom_text to show the gdpPercap at each data point. Since there were only twelve points per two countries the final graph did not look overcrowded. I was also able to find a tutorial that was simple and easy to understand and reinforced some the concepts discussed in class. This is the link 
http://www.stat.wisc.edu/~larget/stat302/chap2.pdf.

Finally, although I know that the %in% operator is far more accurate than using an equality (==) to a vector, I do not know why that is the case. I will have to spend more time attempting to understand how R loops through data in a frame to find a match.








