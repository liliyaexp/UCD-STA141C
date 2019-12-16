## STA 141C Final
library(data.table)
library(tidyverse)

path <- "~/Desktop/Winter Quarter 2019/STA 141C/Final/finaldata.csv"
data <- fread(path)

data$V1 <- NULL
data$index <- NULL

# drop the rows that has no recipient names
data <- data[which(data$recipient_name!=''),]

### find top 10 appearance of recipients: who receive fundings many times
appearance_rep <- table(data$recipient_name)
top10_appearance <- head(appearance_rep[order(appearance_rep, decreasing = T)],10)
top10_appearance

### find top 10 sum obligation by recipient: who receive fundings the most
#top10_sum_data <- data[which(data$recipient_name %in% top10_appearance_names),]
#sum(is.na(top10_sum_data)) # check NaN values
top10_sum_data <- aggregate(data$total_obligation ~ data$recipient_name, data = data, sum)
top10_sum <- head(top10_sum_data[order(top10_sum_data$`data$total_obligation`, decreasing = T),],10)
top10_sum

######## what portions of fundings does each country receive and find the top 10
data_l <- data[which(data$pop_country_name!=""),]
q1 <- aggregate(data_l$total_obligation ~ data_l$pop_country_name, data = data_l, length)
sorted_q1 <- q1[order(q1$`data_l$total_obligation`, decreasing = T),]  # sort q1 by fundings
first10 <- head(sorted_q1,10) # obtain the first 10
first10

