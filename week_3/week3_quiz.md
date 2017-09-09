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

##### Set the working directory:

``` r
setwd("/Users/fer/Dropbox/Coursera DS/Getting_Cleaning_Data/week_3")
```

##### Download file and create a logical vector where ACR = 3 and AGS = 6:

``` r
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
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
conn2 <- download.file(url2, "jeff.jpg", method = "curl")
jeff <- readJPEG("jeff.jpg", native = TRUE)

qwant <- c(0.3, 0.8)
q2 <- quantile(jeff, qwant)
q2
```

    ##       30%       80% 
    ## -15259150 -10575416

``` r
urlgdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urledu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

congdp <- download.file(urlgdp, "gdp.csv", method = "curl")
conedu <- download.file(urledu, "edu.csv", method = "curl")

gdpfile <- read.csv("gdp.csv", header = T, skip = 4, nrows = 215)
edufile <- read.csv("edu.csv", header = T)
#head(gdpfile)
#head(edufile)

gdpfilesel <- gdpfile %>% tbl_df() %>% 
    select(X, X.1, X.3, X.4) 

colnames(gdpfilesel) <- c("CountryCode","Ranking", "Long.Name", "GDP")

edufile <- edufile %>% tbl_df()
gdpmerge <- gdpfilesel %>% merge(edufile, by = "CountryCode") %>%
    tbl_df() %>% 
    filter(Ranking != "") %>%
    mutate(GDP = gsub(",","",GDP)) %>%
    mutate(GDP = as.numeric(GDP)) %>%
    arrange(GDP)
```

    ## Warning: package 'bindrcpp' was built under R version 3.2.5

``` r
q3 <- gdpmerge[13, 3]
q3
```

    ## # A tibble: 1 x 1
    ##           Long.Name.x
    ##                <fctr>
    ## 1 St. Kitts and Nevis

``` r
avgs <- gdpfilesel %>% merge(edufile, by = "CountryCode") %>%
    tbl_df() %>% 
    #filter(Ranking != "") %>%
    group_by(Income.Group) %>%
    summarize(avg = mean(as.numeric(Ranking), na.rm = T))

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
