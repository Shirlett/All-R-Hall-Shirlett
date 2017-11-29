# Introduction

A package called nicenum has been created within folder ![Nicenum](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/tree/master/HW09/nicenum) for HW09. It is comprised of two functions where one function formats numbers as percentages and another transforms the number into significant figures as defined by the user.
The package was tested extensively for potential errors using the script found ![here](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW09/nicenum/tests/testthat/test_nicenum.R) and checking the package revealed no warnings or errors as shown below:
![](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW09/Checkresults.png)

There is extensive documentation for the package found in the 
1. ![Manuals](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/tree/master/HW09/nicenum/man)
2. ![Vignette](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW09/nicenum/vignettes/vignette.Rmd), and 
3. ![Readme](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW09/nicenum/README.md)

# Reflection
Getting an error free check was the most difficult aspect of this homework. I had included examples in the header portion of each function and the check tried to also run them. The solution was to encase the examples in the \dontrun{} function. The inspiration for the functions came from a combinaton of reviewing solutions on stack overflow and from own experiences with formatting numbers for graph axes.  





