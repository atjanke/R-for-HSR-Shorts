# *** R for Health Services Research *** #

#### Housekeeping
install.packages("tidyverse")
install.packages("haven")

library(tidyverse)


#### Opening the data
# National Hospital Ambulatory Care Survey
# emergency department visits, 1,000s ED visits in here

df_survey <- haven::read_stata("ED2019-stata.dta") %>%
  haven::zap_labels()


#### What is in the data?
df_survey
colnames(df_survey)


df_for_plot <- df_survey %>%
  select(AGE,SEX,CATSCAN) %>%
  mutate(SEX = ifelse(SEX==2,"male","female")) %>%
  group_by(AGE,SEX) %>%
  summarise(
    CT.Scan.Total = sum(CATSCAN),
    Total.Visits  = n()) %>%
  mutate(CT.Scan.Rate = CT.Scan.Total/Total.Visits)


#### How to make a plot?
ggplot(df_for_plot) +
  geom_point(aes(x=AGE,y=CT.Scan.Rate,color=SEX))
