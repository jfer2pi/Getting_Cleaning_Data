Getting and Cleaning Data: Week 3 Quiz
================

Question 1
----------

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?

``` r
# Set working directory
setwd("/Users/fer/Dropbox/Coursera DS/Getting_Cleaning_Data/week_3")

# Download file and create a logical vector where ACR = 3 and AGS = 6:
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
conn1 <- download.file(url1, "idaho.csv", method = "curl")

file1 <- read.csv("idaho.csv", header = T)
file1 <- tbl_df(file1)
agricultureLogical <- (file1$ACR == 3 & file1$AGS == 6)
q1 <- which(agricultureLogical)[1:3]
```

##### Answer to Question 1:

``` r
q1
```

    ## [1] 125 238 262

Question 2
----------

Using the jpeg package read in the following picture of your instructor into R

<https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg>

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

``` r
# Set URL
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

# Download file
conn2 <- download.file(url2, "jeff.jpg", method = "curl")

# Read file into R
jeff <- readJPEG("jeff.jpg", native = TRUE)

# Create quantiles
qwant <- c(0.3, 0.8)
q2 <- quantile(jeff, qwant)
```

##### Answer to Question 2:

``` r
# Print answer
q2
```

    ##       30%       80% 
    ## -15259150 -10575416

Question 3
----------

Load the Gross Domestic Product data for the 190 ranked countries in this data set: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Load the educational data from this data set: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

Match the data based on the country shortcode. How many of the IDs match?

Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources: <http://data.worldbank.org/data-catalog/GDP-ranking-table> <http://data.worldbank.org/data-catalog/ed-stats>

``` r
# Set up URLs for files
urlgdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urledu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Download files
congdp <- download.file(urlgdp, "gdp.csv", method = "curl")
conedu <- download.file(urledu, "edu.csv", method = "curl")

# Read files into R, where the GDP file needs to be cleaned by reading only rows 4 to 215
gdpfile <- read.csv("gdp.csv", header = T, skip = 4, nrows = 215)
edufile <- read.csv("edu.csv", header = T)

# Chain and select only columns with data and change column names with sensible names
gdpfilesel <- gdpfile %>% 
    tbl_df() %>% 
    select(X, X.1, X.3, X.4)

colnames(gdpfilesel) <- c("CountryCode", "Ranking", "Long.Name", "GDP")
    
# Transform edu file into a tbldf
edufile <- edufile %>% 
    tbl_df()

# Merge data and clean up, remove Rankings with no data, clean up GDP data and transform as numeric, then sort by GDP 
gdpmerge <- gdpfilesel %>% merge(edufile, by = "CountryCode") %>%
    tbl_df() %>% 
    filter(Ranking != "") %>%
    mutate(GDP = gsub(",","",GDP)) %>%
    mutate(GDP = as.numeric(GDP)) %>%
    mutate(Ranking = as.numeric(Ranking)) %>%
    arrange(GDP)
```

    ## Warning: package 'bindrcpp' was built under R version 3.2.5

##### Answer to Question 3a:

``` r
# Count number of matching rows and print answer
q <- nrow(gdpmerge)
q
```

    ## [1] 189

##### Answer to Question 3b:

``` r
# Print out 13th country name in set
q3 <- gdpmerge[13, 3]
q3
```

    ## # A tibble: 1 x 1
    ##           Long.Name.x
    ##                <fctr>
    ## 1 St. Kitts and Nevis

Question 4
----------

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

``` r
# Chain functions to take merged, clean dataset and group by income, then summarize as average of Ranking
avgs <- gdpmerge %>%
    group_by(Income.Group) %>%
    summarize(avg = mean(as.numeric(Ranking), na.rm = T))
```

##### Answer to Question 4:

``` r
# Print out the averages by income group
avgs
```

    ## # A tibble: 5 x 2
    ##           Income.Group       avg
    ##                 <fctr>     <dbl>
    ## 1 High income: nonOECD  91.91304
    ## 2    High income: OECD  32.96667
    ## 3           Low income 133.72973
    ## 4  Lower middle income 107.70370
    ## 5  Upper middle income  92.13333

Question 5
----------

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

``` r
# Create the cuts in the dataset by five quantile groups in Ranking
splits <- gdpmerge$Ranking %>% quantile(probs = seq(0, 1, 0.2), na.rm = T)

# Do the actual cuts and filter by lower middle income, select the Ranking column and make a table
splitgdp <- gdpmerge %>%
    mutate(Ranking = cut(Ranking, breaks = splits)) %>%
    filter(Income.Group == "Lower middle income") %>% 
    select(Ranking) %>% 
    table()
```

##### Answer to Question 5:

``` r
# Print answer
splitgdp
```

    ## .
    ##    (1,38.6] (38.6,76.2]  (76.2,114]   (114,152]   (152,190] 
    ##           5          13          11           9          16
