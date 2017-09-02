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
#conn1 <- download.file(url1, "idaho.csv", method = "curl")

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

gdpfile <- read.csv("gdp.csv", header = T, skip = 4)
edufile <- read.csv("edu.csv", header = T)
head(gdpfile)
```

    ##     X X.1 X.2            X.3          X.4 X.5 X.6 X.7 X.8 X.9
    ## 1 USA   1  NA  United States  16,244,600       NA  NA  NA  NA
    ## 2 CHN   2  NA          China   8,227,103       NA  NA  NA  NA
    ## 3 JPN   3  NA          Japan   5,959,718       NA  NA  NA  NA
    ## 4 DEU   4  NA        Germany   3,428,131       NA  NA  NA  NA
    ## 5 FRA   5  NA         France   2,612,878       NA  NA  NA  NA
    ## 6 GBR   6  NA United Kingdom   2,471,784       NA  NA  NA  NA

``` r
head(edufile)
```

    ##   CountryCode                    Long.Name         Income.Group
    ## 1         ABW                        Aruba High income: nonOECD
    ## 2         ADO      Principality of Andorra High income: nonOECD
    ## 3         AFG Islamic State of Afghanistan           Low income
    ## 4         AGO  People's Republic of Angola  Lower middle income
    ## 5         ALB          Republic of Albania  Upper middle income
    ## 6         ARE         United Arab Emirates High income: nonOECD
    ##                       Region Lending.category Other.groups  Currency.Unit
    ## 1  Latin America & Caribbean                                Aruban florin
    ## 2      Europe & Central Asia                                         Euro
    ## 3                 South Asia              IDA         HIPC Afghan afghani
    ## 4         Sub-Saharan Africa              IDA              Angolan kwanza
    ## 5      Europe & Central Asia             IBRD                Albanian lek
    ## 6 Middle East & North Africa                                U.A.E. dirham
    ##   Latest.population.census  Latest.household.survey
    ## 1                     2000                         
    ## 2           Register based                         
    ## 3                     1979               MICS, 2003
    ## 4                     1970 MICS, 2001, MIS, 2006/07
    ## 5                     2001               MICS, 2005
    ## 6                     2005                         
    ##                                                                 Special.Notes
    ## 1                                                                            
    ## 2                                                                            
    ## 3 Fiscal year end: March 20; reporting period for national accounts data: FY.
    ## 4                                                                            
    ## 5                                                                            
    ## 6                                                                            
    ##   National.accounts.base.year National.accounts.reference.year
    ## 1                        1995                               NA
    ## 2                                                           NA
    ## 3                   2002/2003                               NA
    ## 4                        1997                               NA
    ## 5                                                         1996
    ## 6                        1995                               NA
    ##   System.of.National.Accounts SNA.price.valuation
    ## 1                          NA                    
    ## 2                          NA                    
    ## 3                          NA                 VAB
    ## 4                          NA                 VAP
    ## 5                        1993                 VAB
    ## 6                          NA                 VAB
    ##   Alternative.conversion.factor PPP.survey.year
    ## 1                                            NA
    ## 2                                            NA
    ## 3                                            NA
    ## 4                       1991-96            2005
    ## 5                                          2005
    ## 6                                            NA
    ##   Balance.of.Payments.Manual.in.use External.debt.Reporting.status
    ## 1                                                                 
    ## 2                                                                 
    ## 3                                                           Actual
    ## 4                              BPM5                         Actual
    ## 5                              BPM5                         Actual
    ## 6                              BPM4                               
    ##   System.of.trade Government.Accounting.concept
    ## 1         Special                              
    ## 2         General                              
    ## 3         General                  Consolidated
    ## 4         Special                              
    ## 5         General                  Consolidated
    ## 6         General                  Consolidated
    ##   IMF.data.dissemination.standard
    ## 1                                
    ## 2                                
    ## 3                            GDDS
    ## 4                            GDDS
    ## 5                            GDDS
    ## 6                            GDDS
    ##   Source.of.most.recent.Income.and.expenditure.data
    ## 1                                                  
    ## 2                                                  
    ## 3                                                  
    ## 4                                         IHS, 2000
    ## 5                                        LSMS, 2005
    ## 6                                                  
    ##   Vital.registration.complete Latest.agricultural.census
    ## 1                                                       
    ## 2                         Yes                           
    ## 3                                                       
    ## 4                                                1964-65
    ## 5                         Yes                       1998
    ## 6                                                   1998
    ##   Latest.industrial.data Latest.trade.data Latest.water.withdrawal.data
    ## 1                     NA              2008                           NA
    ## 2                     NA              2006                           NA
    ## 3                     NA              2008                         2000
    ## 4                     NA              1991                         2000
    ## 5                   2005              2008                         2000
    ## 6                     NA              2008                         2005
    ##   X2.alpha.code WB.2.code           Table.Name           Short.Name
    ## 1            AW        AW                Aruba                Aruba
    ## 2            AD        AD              Andorra              Andorra
    ## 3            AF        AF          Afghanistan          Afghanistan
    ## 4            AO        AO               Angola               Angola
    ## 5            AL        AL              Albania              Albania
    ## 6            AE        AE United Arab Emirates United Arab Emirates

``` r
gdpfile <- gdpfile %>% tbl_df() %>% select(X, X.1, X.3, X.4) 
colnames(gdpfile) <- c("CountryCode","Ranking", "Long.Name", "GDP")
head(gdpfile)
```

    ## # A tibble: 6 x 4
    ##   CountryCode Ranking      Long.Name          GDP
    ##        <fctr>  <fctr>         <fctr>       <fctr>
    ## 1         USA       1  United States  16,244,600 
    ## 2         CHN       2          China   8,227,103 
    ## 3         JPN       3          Japan   5,959,718 
    ## 4         DEU       4        Germany   3,428,131 
    ## 5         FRA       5         France   2,612,878 
    ## 6         GBR       6 United Kingdom   2,471,784

``` r
edufile <- edufile %>% tbl_df()

mergeData <- merge(gdpfile, edufile, by = "CountryCode")
head(mergeData)
```

    ##   CountryCode Ranking          Long.Name.x       GDP
    ## 1         ABW     161                Aruba    2,584 
    ## 2         ADO                      Andorra        ..
    ## 3         AFG     105          Afghanistan   20,497 
    ## 4         AGO      60               Angola  114,147 
    ## 5         ALB     125              Albania   12,648 
    ## 6         ARE      32 United Arab Emirates  348,595 
    ##                    Long.Name.y         Income.Group
    ## 1                        Aruba High income: nonOECD
    ## 2      Principality of Andorra High income: nonOECD
    ## 3 Islamic State of Afghanistan           Low income
    ## 4  People's Republic of Angola  Lower middle income
    ## 5          Republic of Albania  Upper middle income
    ## 6         United Arab Emirates High income: nonOECD
    ##                       Region Lending.category Other.groups  Currency.Unit
    ## 1  Latin America & Caribbean                                Aruban florin
    ## 2      Europe & Central Asia                                         Euro
    ## 3                 South Asia              IDA         HIPC Afghan afghani
    ## 4         Sub-Saharan Africa              IDA              Angolan kwanza
    ## 5      Europe & Central Asia             IBRD                Albanian lek
    ## 6 Middle East & North Africa                                U.A.E. dirham
    ##   Latest.population.census  Latest.household.survey
    ## 1                     2000                         
    ## 2           Register based                         
    ## 3                     1979               MICS, 2003
    ## 4                     1970 MICS, 2001, MIS, 2006/07
    ## 5                     2001               MICS, 2005
    ## 6                     2005                         
    ##                                                                 Special.Notes
    ## 1                                                                            
    ## 2                                                                            
    ## 3 Fiscal year end: March 20; reporting period for national accounts data: FY.
    ## 4                                                                            
    ## 5                                                                            
    ## 6                                                                            
    ##   National.accounts.base.year National.accounts.reference.year
    ## 1                        1995                               NA
    ## 2                                                           NA
    ## 3                   2002/2003                               NA
    ## 4                        1997                               NA
    ## 5                                                         1996
    ## 6                        1995                               NA
    ##   System.of.National.Accounts SNA.price.valuation
    ## 1                          NA                    
    ## 2                          NA                    
    ## 3                          NA                 VAB
    ## 4                          NA                 VAP
    ## 5                        1993                 VAB
    ## 6                          NA                 VAB
    ##   Alternative.conversion.factor PPP.survey.year
    ## 1                                            NA
    ## 2                                            NA
    ## 3                                            NA
    ## 4                       1991-96            2005
    ## 5                                          2005
    ## 6                                            NA
    ##   Balance.of.Payments.Manual.in.use External.debt.Reporting.status
    ## 1                                                                 
    ## 2                                                                 
    ## 3                                                           Actual
    ## 4                              BPM5                         Actual
    ## 5                              BPM5                         Actual
    ## 6                              BPM4                               
    ##   System.of.trade Government.Accounting.concept
    ## 1         Special                              
    ## 2         General                              
    ## 3         General                  Consolidated
    ## 4         Special                              
    ## 5         General                  Consolidated
    ## 6         General                  Consolidated
    ##   IMF.data.dissemination.standard
    ## 1                                
    ## 2                                
    ## 3                            GDDS
    ## 4                            GDDS
    ## 5                            GDDS
    ## 6                            GDDS
    ##   Source.of.most.recent.Income.and.expenditure.data
    ## 1                                                  
    ## 2                                                  
    ## 3                                                  
    ## 4                                         IHS, 2000
    ## 5                                        LSMS, 2005
    ## 6                                                  
    ##   Vital.registration.complete Latest.agricultural.census
    ## 1                                                       
    ## 2                         Yes                           
    ## 3                                                       
    ## 4                                                1964-65
    ## 5                         Yes                       1998
    ## 6                                                   1998
    ##   Latest.industrial.data Latest.trade.data Latest.water.withdrawal.data
    ## 1                     NA              2008                           NA
    ## 2                     NA              2006                           NA
    ## 3                     NA              2008                         2000
    ## 4                     NA              1991                         2000
    ## 5                   2005              2008                         2000
    ## 6                     NA              2008                         2005
    ##   X2.alpha.code WB.2.code           Table.Name           Short.Name
    ## 1            AW        AW                Aruba                Aruba
    ## 2            AD        AD              Andorra              Andorra
    ## 3            AF        AF          Afghanistan          Afghanistan
    ## 4            AO        AO               Angola               Angola
    ## 5            AL        AL              Albania              Albania
    ## 6            AE        AE United Arab Emirates United Arab Emirates
