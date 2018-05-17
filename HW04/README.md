The output of this exercise can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW04/STAT545-HW04.md).


# Reflection

Overall, this  assignment was fairly challenging. This was mainly as a result of my desire to express the new shape of the life expectancy ranking table in a meaningful way. Although the requirements were only to reshape the three columns- year, country and lifeExp, I did not think the result was adequate. If I did not know what the intent of the original code was, I would not be able to look at the final table and fully understand the figures.

I used the do command to isolate only the countries and lifeExp with the minimum rankings within a year then tagged those with the term minimum. The same thing was repeated for maximum rankings. The main challenge was figuring out how to spread by multiple columns. I attempted to spread one key-value pair into a new table, then spread again on the new table. However, the format was extremely disjointed becuase the mins were on one row and max levels were on another row so the year was still being repeated.
Luckily, I was able to find a similar question on Stack Overflow. The disjointed issue was resolved with the summarise function. The link is https://stackoverflow.com/questions/31687180/spread-multiple-coordinated-columns/31687741#31687741.

The join, merge and match activities were pretty straightforward although I am not sure about the appropriate format to display the final results. Since most of the results returned all the rows of gapminder, I elected to summarize the results by summing the population for 2007 for the joins and using the structure function for the merge. These options show the presence/absence of the variables/rows that are produced by the join and merge.

