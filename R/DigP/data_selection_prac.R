install.packages("dplyr")
install.packages("FSAdata")
install.packages("plotrix")

library("dplyr")
library(FSAdata)
library(plotrix)


#the RuffeSLRH92data frame is then loaded.

data(RuffeSLRH92)
str(RuffeSLRH92)


#-----------
#Select (columns) Examples
#-----------

RuffeSLRH92<-select(RuffeSLRH92, -fish.id, -day, -year)
head(RuffeSLRH92)

#creates a data.frame of just the legth and weight variables
ruffeLW <- select(RuffeSLRH92, length, weight)
head(ruffeLW)

#select all variabels that contains the letter "l".
ruffeL<-select(RuffeSLRH92, contains("l"))
str(ruffeL)

#-------------
#Filtering Example
#-------------

#The example below finds just the males from the original data.frame.


#filter() returns an object that maintains a list of the
#original levels whether thos levels exist in the new data.frame or not.
male<-filter(RuffeSLRH92, sex=="male")
xtabs(~sex, data=male)

#droplevels() to restrict the levels to only thos that exist in the data.frame
male<-droplevels(male)
xtabs(~sex, data=male)


#multiple conditioning statements can be strung together as additional
#arguments to filter().

maleripe<-filter(RuffeSLRH92, sex=="male", maturity=="ripe")
xtabs(~sex+maturity, data=maleripe)

#' an "or" needs to be completed as with subset()
maleripe2<-filter(RuffeSLRH92, sex=="male" | maturity=="ripe")
xtabs(~sex+maturity, data=maleripe2)



#################
# Arrange Example
#################

malea<-arrange(male, length)
head(malea)

tail(malea)


#descending order
maled<-arrange(male, desc(length))
head(maled)

tail(maled)

#multiple levels of ordering canbe completed by including multiple variables

ruffe2<-arrange(RuffeSLRH92, length, weight)
head(ruffe2)

tail(ruffe2)



###################
#Add new variables (i.e., columns) Example
###################

ruffeLW<-mutate(ruffeLW, logL=log(length), logW=log(weight))
head(ruffeLW)



###################
#Aggregation and Summarization Example
###################

byMon<-group_by(RuffeSLRH92,month)
( sumMon <- summarize(byMon, count=n()))


byMonSex<-group_by(RuffeSLRH92, month, sex)
( sumMonSex <- summarize(byMonSex, count=n()))

( LenSumMon <- summarize(byMon, n=n(), mn=mean(length), sd=sd(length)) )


###################
#Putting It All Together
###################
library(magrittr)

#compute the proportion of all captured fish captured in each month by
#' (1) grouping the data by month,
#' (2) summarizing the number per month,
#' (3) adding a new variable that is the proportion of the total catch
#' in each month, and then
#' (4) sorting the results such that the month with the largest catch is
#' listed first

fnl1 <- RuffeSLRH92 %>%
  group_by(month) %>%
  summarize(n=n()) %>%
  mutate(prop.catch=n/sum(n)) %>%
  arrange(desc(prop.catch))
fnl1



fnl2<-RuffeSLRH92 %>%
  group_by(month) %>%
  summarize(n=n(), mn=mean(length), sd=sd(length))%>%
  mutate(se=sd/sqrt(n), LCI=mn+qnorm(0.025)*se, UCI=mn+qnorm(0.975)*se)
fnl2
