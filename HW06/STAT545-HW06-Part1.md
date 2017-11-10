# STAT545-HW06-Part1
Shirlett  
November 5, 2017  



#1. String Instruments from http://r4ds.had.co.nz/strings.html
##14.2.5 - String Basics

```r
#1.
#Paste prints strings and leaves a space separator by default
(pst<-paste("Tom", "Dick", "Harry", NA)) 
```

```
## [1] "Tom Dick Harry NA"
```

```r
#Paste0 prints strings and omits the space between the strings
(pst0<-paste0("Tom", "Dick", "Harry", NA)) 
```

```
## [1] "TomDickHarryNA"
```

```r
#Both paste and paste0 are roughly equivalent to the str_c but paste0 more closely replicates 

#the  str_c function
(strc <- str_c("Tom", "Dick", "Harry", NA)) 
```

```
## [1] NA
```

```r
#Paste functions treat NA as they would any other string and prints NA, whereas str_c sees it as

#missing data that has to be replaced


#2.The sep arguement is an indication of the string to insert between vectors whereas collapse

#is an indication of the string that should be used to combine vectors into a single string.
str_c("a","b", c("c","d"), sep = " ", collapse = ",")
```

```
## [1] "a b c,a b d"
```

```r
str_c("a","b", c("c","d"), sep = " ")
```

```
## [1] "a b c" "a b d"
```

```r
#3.Using str_length and str_sub to extract a middle character(s) whether the length of the

#string is odd or even

#Function to test the length of a given string
my_string <- function(x) {
if((str_length(x) %% 2) == 0) {
    str_sub(x, (str_length(x)/2), ((str_length(x)/2)+1))
} else {
    str_sub(x, ((str_length(x)+1)/2), ((str_length(x)+1)/2))
}
}

my_string("middle")
```

```
## [1] "dd"
```

```r
my_string("tower")
```

```
## [1] "w"
```

```r
#4.
str_wrap("str_wrap can be used to format paragraphs by controlling the width and indentation. This is useful for printing long paragraphs", width=60)
```

```
## [1] "str_wrap can be used to format paragraphs by controlling\nthe width and indentation. This is useful for printing long\nparagraphs"
```

```r
#5.str_trim removes whitespace to the left or right of strings. Its counterpart 

#is str_pad() which adds whitespace.

#6.Convert a vector of strings into a single string and consider less than optimal vector

#lengths, such as two, one or zero

x = c("a", "b", "c")
y = c("a", "b")
z = c("a")
alpha = c("")

#Function to test the length of vector and modify format of the output accordingly
my_conversion <- function(vec) {
  converted <- ""
  if (length(vec) < 2)
  {
    converted <- str_c(vec)
  }
  else if (length(vec) == 2)
  {
    converted <- str_c(converted, vec[1], " and ", vec[2])
  }
  else
  {
    for (i in 1:(length(vec)-2))
    {
      converted <- str_c(converted, vec[i], ", ")
    }
    converted <- str_c(converted, vec[length(vec)-1], ", and ", vec[length(vec)])
  }
  return(converted)
}

my_conversion(x)
```

```
## [1] "a, b, and c"
```

```r
my_conversion(y)
```

```
## [1] "a and b"
```

```r
my_conversion(z)
```

```
## [1] "a"
```

```r
my_conversion(alpha)
```

```
## [1] ""
```

##14.3.1.1 - Basic Matches

```r
#1. Explanation of why each of these strings donât match a \: "\", "\\", "\\\".

#"\" indicates an escape from prior text

#"\\" indicates the creation of a regular expression and be recognized as \

#"\\\" indicates that the backslash character needs to be matched


#2. Matching the sequence "'\

test<- "\"'\\"
str_view(test, "\\\"'\\\\")
```

<!--html_preserve--><div id="htmlwidget-5aebcc76bb7ce261aaeb" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-5aebcc76bb7ce261aaeb">{"x":{"html":"<ul>\n  <li><span class='match'>\"'\\\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#3. Patterns matched by the regular expression \..\..\.

test2 <- "covers.x.y.z"
#str_view(test2, "\\..\\..\\..")
#Patterns that are a dot followed by any character, three consecutive times
```


##14.3.2.1 - Anchors

```r
#1. Match the literal string "$^$"
test3<- "goodness$^$gracious"
#str_view(test3, "\\$\\^\\$")

#2. Regular Expressions to match common words in stringr::words:
#that start with y
#str_view(words, "^y", match = TRUE)

#that end with x
#str_view(words, "x$", match = TRUE)

#are exactly three letters long
#str_view(words, "^...$", match = TRUE)

#have seven letters or more
#str_view(words, ".......", match = TRUE)
```


##14.3.3.1 - Character Classes and Alternatives

```r
#1. Regular expressions to find words that:
#Start with a vowel
#str_view(words, "^[aeouiy]", match = TRUE)

#Only contain consonants
#str_view(words, "^[^aeouiy]*$", match = TRUE)

#End with ed but not with eed
#str_view(words, "[^e]ed$", match = TRUE)

#End with ing or ise
#str_view(words, "i(ng|se)$", match = TRUE)


#2.Verify the rule âi before e except after câ
#Well e comes before i in weigh
#str_view(words, "([^c])ei", match = TRUE)


#3. Verify that q is always followed by a u
#C'est vrai
#str_view(words, "q[^u]", match = TRUE)


#4. An expression that finds a word from British vs American English
#str_view(words, "[a-z][a-z]our$", match = TRUE)

#5. An expression that finds a string that will match phone numbers as written in Jamaica
phone <- (c("1876-928-4712", "186-748-422"))
#str_view(phone, "1876-\\d\\d\\d-\\d\\d\\d\\d", match = TRUE)
```


##14.3.4.1 - Repetition

```r
#1. Equivalents in {m,n} form of the following:
#? - zero or one instance is equivalent to:
#{,n}: match one at most

#+ - one or more repeats is equivalent to:
#{n,}: n or more 


#* - zero or more repeats is only roughly equivalent to:
#{,m}: at most m


#2. Description of matches to the following regular expressions:
#^.*$ - This would match any length or any character
#"\\{.+\\}" - This would match at least one character
#\d{4}-\d{2}-\d{2} - This would match 4 repeated digits- 2 repeated digits - two repeated digits
# "\\\\{4}" - This would match \\\\


#3. Regular expressions to find words that:
#Start with three consonants.
#str_view(words, "^[^aeouiy]{3}", match = TRUE)

#Have three or more vowels in a row.
#str_view(words, "[aeouiy]{3,}", match = TRUE)

#Have two or more vowel-consonant pairs in a row.
#str_view(words, "([aeouiy][^aeouiy]){2,}", match = TRUE)
```

##14.3.5.1 - Grouping and Backreferences

```r
#1. Description of the matches to the following:
#(.)\1\1 - Matches any single characters that repeat three times
test4 = "ssstreat"
#str_view(test4, "(.)\\1\\1", match = TRUE)

#"(.)(.)\\2\\1" - matches any single non repeating character then a character that repeats 

#twice then the same first character
test5 = "abbacadabra"
#str_view(test5, "(.)(.)\\2\\1", match = TRUE)

#(..)\1 - Find repeated pair of letters
test6 = "cucumber" 
#str_view(test6, "(..)\\1", match = TRUE)

#"(.).\\1.\\1" - Match one character then any single character, then the same first character,
#then any single character, then another repeat of the first character
test7 = "tatet"
#str_view(test7, "(.).\\1.\\1", match = TRUE)

#"(.)(.)(.).*\\3\\2\\1" - Match 2-3 single characters, 0 or more random characters, then the 
#same first 2-3 characters in reverse
test8 = "abctatetcba"
#str_view(test8, "(.)(.)(.).*\\3\\2\\1", match = TRUE)


#2. Regular expressions to match words that:

#Start and end with the same character.
#str_view(words, "^(.).*\\1$", match = T)

#Contain a repeated pair of letters (e.g. âchurchâ contains âchâ repeated twice.)
#str_view(words, "(..).*\\1", match = T)

#Contain one letter repeated in at least three places (e.g. âelevenâ contains three âeâs.)
#str_view(words, "(.).*\\1.*\\1", match = T)
```

##14.4.2 - Detect Matches

```r
#1. Using Regular expressions and str_detect:
#Words that start or end with x
str_view(words, "^x|x$", match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-66b590831455167acfcf" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-66b590831455167acfcf">{"x":{"html":"<ul>\n  <li>bo<span class='match'>x\u003c/span>\u003c/li>\n  <li>se<span class='match'>x\u003c/span>\u003c/li>\n  <li>si<span class='match'>x\u003c/span>\u003c/li>\n  <li>ta<span class='match'>x\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
start_with_x = str_detect(words, "^x")
end_with_x = str_detect(words, "x$")
words[start_with_x | end_with_x]
```

```
## [1] "box" "sex" "six" "tax"
```

```r
#Words that start with a vowel and end with a consonant
str_view(words, "^[aeuioy].*[^aeuioy]$", match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-b2e74f6b08fb68c1360d" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-b2e74f6b08fb68c1360d">{"x":{"html":"<ul>\n  <li><span class='match'>about\u003c/span>\u003c/li>\n  <li><span class='match'>accept\u003c/span>\u003c/li>\n  <li><span class='match'>account\u003c/span>\u003c/li>\n  <li><span class='match'>across\u003c/span>\u003c/li>\n  <li><span class='match'>act\u003c/span>\u003c/li>\n  <li><span class='match'>actual\u003c/span>\u003c/li>\n  <li><span class='match'>add\u003c/span>\u003c/li>\n  <li><span class='match'>address\u003c/span>\u003c/li>\n  <li><span class='match'>admit\u003c/span>\u003c/li>\n  <li><span class='match'>affect\u003c/span>\u003c/li>\n  <li><span class='match'>afford\u003c/span>\u003c/li>\n  <li><span class='match'>after\u003c/span>\u003c/li>\n  <li><span class='match'>afternoon\u003c/span>\u003c/li>\n  <li><span class='match'>again\u003c/span>\u003c/li>\n  <li><span class='match'>against\u003c/span>\u003c/li>\n  <li><span class='match'>agent\u003c/span>\u003c/li>\n  <li><span class='match'>air\u003c/span>\u003c/li>\n  <li><span class='match'>all\u003c/span>\u003c/li>\n  <li><span class='match'>allow\u003c/span>\u003c/li>\n  <li><span class='match'>almost\u003c/span>\u003c/li>\n  <li><span class='match'>along\u003c/span>\u003c/li>\n  <li><span class='match'>alright\u003c/span>\u003c/li>\n  <li><span class='match'>although\u003c/span>\u003c/li>\n  <li><span class='match'>always\u003c/span>\u003c/li>\n  <li><span class='match'>amount\u003c/span>\u003c/li>\n  <li><span class='match'>and\u003c/span>\u003c/li>\n  <li><span class='match'>another\u003c/span>\u003c/li>\n  <li><span class='match'>answer\u003c/span>\u003c/li>\n  <li><span class='match'>apart\u003c/span>\u003c/li>\n  <li><span class='match'>apparent\u003c/span>\u003c/li>\n  <li><span class='match'>appear\u003c/span>\u003c/li>\n  <li><span class='match'>appoint\u003c/span>\u003c/li>\n  <li><span class='match'>approach\u003c/span>\u003c/li>\n  <li><span class='match'>arm\u003c/span>\u003c/li>\n  <li><span class='match'>around\u003c/span>\u003c/li>\n  <li><span class='match'>art\u003c/span>\u003c/li>\n  <li><span class='match'>as\u003c/span>\u003c/li>\n  <li><span class='match'>ask\u003c/span>\u003c/li>\n  <li><span class='match'>at\u003c/span>\u003c/li>\n  <li><span class='match'>attend\u003c/span>\u003c/li>\n  <li><span class='match'>awful\u003c/span>\u003c/li>\n  <li><span class='match'>each\u003c/span>\u003c/li>\n  <li><span class='match'>east\u003c/span>\u003c/li>\n  <li><span class='match'>eat\u003c/span>\u003c/li>\n  <li><span class='match'>effect\u003c/span>\u003c/li>\n  <li><span class='match'>egg\u003c/span>\u003c/li>\n  <li><span class='match'>eight\u003c/span>\u003c/li>\n  <li><span class='match'>either\u003c/span>\u003c/li>\n  <li><span class='match'>elect\u003c/span>\u003c/li>\n  <li><span class='match'>electric\u003c/span>\u003c/li>\n  <li><span class='match'>eleven\u003c/span>\u003c/li>\n  <li><span class='match'>end\u003c/span>\u003c/li>\n  <li><span class='match'>english\u003c/span>\u003c/li>\n  <li><span class='match'>enough\u003c/span>\u003c/li>\n  <li><span class='match'>enter\u003c/span>\u003c/li>\n  <li><span class='match'>environment\u003c/span>\u003c/li>\n  <li><span class='match'>equal\u003c/span>\u003c/li>\n  <li><span class='match'>especial\u003c/span>\u003c/li>\n  <li><span class='match'>even\u003c/span>\u003c/li>\n  <li><span class='match'>evening\u003c/span>\u003c/li>\n  <li><span class='match'>ever\u003c/span>\u003c/li>\n  <li><span class='match'>exact\u003c/span>\u003c/li>\n  <li><span class='match'>except\u003c/span>\u003c/li>\n  <li><span class='match'>exist\u003c/span>\u003c/li>\n  <li><span class='match'>expect\u003c/span>\u003c/li>\n  <li><span class='match'>explain\u003c/span>\u003c/li>\n  <li><span class='match'>express\u003c/span>\u003c/li>\n  <li><span class='match'>if\u003c/span>\u003c/li>\n  <li><span class='match'>important\u003c/span>\u003c/li>\n  <li><span class='match'>in\u003c/span>\u003c/li>\n  <li><span class='match'>indeed\u003c/span>\u003c/li>\n  <li><span class='match'>individual\u003c/span>\u003c/li>\n  <li><span class='match'>inform\u003c/span>\u003c/li>\n  <li><span class='match'>instead\u003c/span>\u003c/li>\n  <li><span class='match'>interest\u003c/span>\u003c/li>\n  <li><span class='match'>invest\u003c/span>\u003c/li>\n  <li><span class='match'>it\u003c/span>\u003c/li>\n  <li><span class='match'>item\u003c/span>\u003c/li>\n  <li><span class='match'>obvious\u003c/span>\u003c/li>\n  <li><span class='match'>occasion\u003c/span>\u003c/li>\n  <li><span class='match'>odd\u003c/span>\u003c/li>\n  <li><span class='match'>of\u003c/span>\u003c/li>\n  <li><span class='match'>off\u003c/span>\u003c/li>\n  <li><span class='match'>offer\u003c/span>\u003c/li>\n  <li><span class='match'>often\u003c/span>\u003c/li>\n  <li><span class='match'>old\u003c/span>\u003c/li>\n  <li><span class='match'>on\u003c/span>\u003c/li>\n  <li><span class='match'>open\u003c/span>\u003c/li>\n  <li><span class='match'>or\u003c/span>\u003c/li>\n  <li><span class='match'>order\u003c/span>\u003c/li>\n  <li><span class='match'>original\u003c/span>\u003c/li>\n  <li><span class='match'>other\u003c/span>\u003c/li>\n  <li><span class='match'>ought\u003c/span>\u003c/li>\n  <li><span class='match'>out\u003c/span>\u003c/li>\n  <li><span class='match'>over\u003c/span>\u003c/li>\n  <li><span class='match'>own\u003c/span>\u003c/li>\n  <li><span class='match'>under\u003c/span>\u003c/li>\n  <li><span class='match'>understand\u003c/span>\u003c/li>\n  <li><span class='match'>union\u003c/span>\u003c/li>\n  <li><span class='match'>unit\u003c/span>\u003c/li>\n  <li><span class='match'>unless\u003c/span>\u003c/li>\n  <li><span class='match'>until\u003c/span>\u003c/li>\n  <li><span class='match'>up\u003c/span>\u003c/li>\n  <li><span class='match'>upon\u003c/span>\u003c/li>\n  <li><span class='match'>usual\u003c/span>\u003c/li>\n  <li><span class='match'>year\u003c/span>\u003c/li>\n  <li><span class='match'>yes\u003c/span>\u003c/li>\n  <li><span class='match'>yet\u003c/span>\u003c/li>\n  <li><span class='match'>young\u003c/span>\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
start_with_vowel = str_detect(words, "^[aeuioy]")
end_with_consonant = str_detect(words, "[^aeuioy]$")
words[start_with_vowel & end_with_consonant]
```

```
##   [1] "about"       "accept"      "account"     "across"      "act"        
##   [6] "actual"      "add"         "address"     "admit"       "affect"     
##  [11] "afford"      "after"       "afternoon"   "again"       "against"    
##  [16] "agent"       "air"         "all"         "allow"       "almost"     
##  [21] "along"       "alright"     "although"    "always"      "amount"     
##  [26] "and"         "another"     "answer"      "apart"       "apparent"   
##  [31] "appear"      "appoint"     "approach"    "arm"         "around"     
##  [36] "art"         "as"          "ask"         "at"          "attend"     
##  [41] "awful"       "each"        "east"        "eat"         "effect"     
##  [46] "egg"         "eight"       "either"      "elect"       "electric"   
##  [51] "eleven"      "end"         "english"     "enough"      "enter"      
##  [56] "environment" "equal"       "especial"    "even"        "evening"    
##  [61] "ever"        "exact"       "except"      "exist"       "expect"     
##  [66] "explain"     "express"     "if"          "important"   "in"         
##  [71] "indeed"      "individual"  "inform"      "instead"     "interest"   
##  [76] "invest"      "it"          "item"        "obvious"     "occasion"   
##  [81] "odd"         "of"          "off"         "offer"       "often"      
##  [86] "old"         "on"          "open"        "or"          "order"      
##  [91] "original"    "other"       "ought"       "out"         "over"       
##  [96] "own"         "under"       "understand"  "union"       "unit"       
## [101] "unless"      "until"       "up"          "upon"        "usual"      
## [106] "year"        "yes"         "yet"         "young"
```

```r
#Words that contain at least one of each different vowel yields no results
a = str_detect(words, "a+")
e = str_detect(words, "e+")
i = str_detect(words, "i+")
o = str_detect(words, "o+")
u = str_detect(words, "u+")
y = str_detect(words, "y+")
words[a & e & i & o & u & y]
```

```
## character(0)
```

```r
#Words that have the highest proportion of vowels
count_of_vowels = str_count(words, "[aeouiy]")
word_length = str_length(words)
prop_table <- tibble(words = words, counts = count_of_vowels, length = word_length)


prop_table %>%
  mutate(proportion = counts / length) %>%
  arrange(desc(proportion)) %>%
	head(20)
```

```
## # A tibble: 20 x 4
##     words counts length proportion
##     <chr>  <int>  <int>      <dbl>
##  1      a      1      1  1.0000000
##  2    eye      3      3  1.0000000
##  3    you      3      3  1.0000000
##  4   area      3      4  0.7500000
##  5   away      3      4  0.7500000
##  6   easy      3      4  0.7500000
##  7   idea      3      4  0.7500000
##  8   okay      3      4  0.7500000
##  9   year      3      4  0.7500000
## 10    age      2      3  0.6666667
## 11    ago      2      3  0.6666667
## 12    air      2      3  0.6666667
## 13    any      2      3  0.6666667
## 14 beauty      4      6  0.6666667
## 15    boy      2      3  0.6666667
## 16    buy      2      3  0.6666667
## 17    day      2      3  0.6666667
## 18    die      2      3  0.6666667
## 19    due      2      3  0.6666667
## 20    eat      2      3  0.6666667
```

##14.4.3.1 - Extract Matches

```r
#1. Correct the match to flickered

colors <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|")
truecolors <- str_c("\\b(", str_c(colors, collapse = "|"), ")\\b")## add boundaries 
more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, truecolors, match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-4ad8d9f372988d109b2e" style="width:960px;height:auto;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-4ad8d9f372988d109b2e">{"x":{"html":"<ul>\n  <li>It is hard to erase <span class='match'>blue\u003c/span> or <span class='match'>red\u003c/span> ink.\u003c/li>\n  <li>The <span class='match'>green\u003c/span> light in the brown box flickered.\u003c/li>\n  <li>The sky in the west is tinged with <span class='match'>orange\u003c/span> <span class='match'>red\u003c/span>.\u003c/li>\n\u003c/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#Using Harvard sentences data, extract:
#The first word from each sentence
str_extract(sentences, "[a-zA-X]+") %>% head(20)
```

```
##  [1] "The"   "Glue"  "It"    "These" "Rice"  "The"   "The"   "The"  
##  [9] "Four"  "Large" "The"   "A"     "The"   "Kick"  "Help"  "A"    
## [17] "Smoky" "The"   "The"   "The"
```

```r
#All words ending in ing
ending <- str_subset(sentences, "\\b[A-Za-z]+ing\\b")
str_extract(ending, "\\b[A-Za-z]+ing\\b") %>% str_sub(1, -1) %>% head(10)
```

```
##  [1] "spring"  "evening" "morning" "winding" "living"  "king"    "Adding" 
##  [8] "making"  "raging"  "playing"
```

```r
#All plurals
#Plurals that end in es are not captured by regex that I can fathom
#The following retrieves words that end in s and excludes 2 and 3 letter words, like has & is
unique(unlist(str_extract_all(sentences, "\\b[A-Za-z]{3,}s\\b"))) %>%
  head(20)
```

```
##  [1] "planks"    "days"      "bowls"     "lemons"    "makes"    
##  [6] "hogs"      "hours"     "stockings" "helps"     "pass"     
## [11] "fires"     "across"    "bonds"     "Press"     "pants"    
## [16] "useless"   "kittens"   "Sickness"  "grass"     "books"
```

##14.4.4.1 - Grouped Matches

```r
#1. Find words that come after a number
#Pulls out both number name and word
nw <- "(one|two|three|four|five|six|seven|eight|nine|ten) +(\\S+)"
sentences[str_detect(sentences, nw)] %>%
  str_extract(nw)
```

```
##  [1] "ten served"    "one over"      "seven books"   "two met"      
##  [5] "two factors"   "one and"       "three lists"   "seven is"     
##  [9] "two when"      "one floor."    "ten inches."   "one with"     
## [13] "one war"       "one button"    "six minutes."  "ten years"    
## [17] "one in"        "ten chased"    "one like"      "two shares"   
## [21] "two distinct"  "one costs"     "ten two"       "five robins." 
## [25] "four kinds"    "one rang"      "ten him."      "three story"  
## [29] "ten by"        "one wall."     "three inches"  "ten your"     
## [33] "six comes"     "one before"    "three batches" "two leaves."
```

```r
#2. To find contractions
contracted_words <- "([A-Za-z]+)'([A-Za-z]+)"
sentences %>%
  `[`(str_detect(sentences, contracted_words)) %>%
  str_extract(contracted_words)
```

```
##  [1] "It's"       "man's"      "don't"      "store's"    "workmen's" 
##  [6] "Let's"      "sun's"      "child's"    "king's"     "It's"      
## [11] "don't"      "queen's"    "don't"      "pirate's"   "neighbor's"
```

##14.4.5.1- Replacing Matches

```r
#1. Replace forward slash with backward slash
replace_for <- str_replace("How to replace a / with a backslash", "/", "\\\\")  
  								
replace_for
```

```
## [1] "How to replace a \\ with a backslash"
```

```r
#2. Implement a simple version of str_to_lower() using replace_all().

phrase="aLL over tHe pLaCe"
new_phrase <- str_replace_all(phrase, c("L" = "l", "C" = "c", "H" = "h"))
new_phrase
```

```
## [1] "all over the place"
```

```r
#3. Switch the first and last letters in words and count the number of legitimate words

switch<- str_replace(words,"(^.)(.*)(.$)", "\\3\\2\\1")
still_words <- intersect(words, switch)
length(still_words)
```

```
## [1] 45
```

##14.4.6.1 - Splitting

```r
#1. split apples, pears, and bananas into individual components
fruits <- c("apples, pears, and bananas")
str_split(fruits, ", +(and +)?")[[1]]
```

```
## [1] "apples"  "pears"   "bananas"
```

```r
#2. It is better to split by boundary on words because it considers punctuation instead of just whitespace

#3. Result of splitting with an empty string causes words to split apart
str_split("so_very ver y tired!", "")[[1]]
```

```
##  [1] "s" "o" "_" "v" "e" "r" "y" " " "v" "e" "r" " " "y" " " "t" "i" "r"
## [18] "e" "d" "!"
```

##14.5.1 - Other Patterns

```r
#1.One could find all strings containing \ with regex() vs. with fixed() by adding the fixed
#argument to the string function
str_subset(c("stop\\", "please"), "\\\\")
```

```
## [1] "stop\\"
```

```r
str_subset(c("stop\\", "please"), fixed("\\"))
```

```
## [1] "stop\\"
```

```r
#2. Five most common words in sentences
str_extract_all(sentences, boundary("word")) %>%
  unlist() %>%
  str_to_lower() %>%
  tibble() %>%
  set_names("word") %>%
  group_by(word) %>%
  count() %>%
	arrange(desc(n)) %>%
  head(5)
```

```
## # A tibble: 5 x 2
## # Groups:   word [5]
##    word     n
##   <chr> <int>
## 1   the   751
## 2     a   202
## 3    of   132
## 4    to   123
## 5   and   118
```

##14.7.1 - Stringi

```r
#1.
#stringi function that counts the number of words is stri_count words
#Stringi function that finds duplicated strings is stri_duplicated
#Stringi function to generate random text is stri_rand_

#2. To control the language that stri_sort() uses for sorting, one has to change the 
#value within the function related to opts_collator from NULL or ""
```
<a href="#top">Back to top</a>

