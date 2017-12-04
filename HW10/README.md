# Reflection

The link to the markdown file can be found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW10/STAT545-HW10.md).

## Scraping
The main difficulty with this assignment and scraping the web was reading the url. Attempts to directly read the url failed with read_html and caused errors related to the connection. This was resolved by using the command set_config(config(ssl_verifypeer = 0L))

## Combining APIs

Using rplos and rebird was more straightforward. Since the list of bird species was over ten thousand, it seemed unwise to search rplos against this entire list given the strict limits on rplos requests. A test was done with one bird species, and then a wider search was done with more birds. This site was especially useful for finding the options to search the list of published articles:
https://ropensci.org/tutorials/rplos_tutorial/



