#### STA141C HW1 - LIYA LI
##############
############## Timer Setting
############## before everything, set timer to calculate execution time of the whole script
start_time = Sys.time()

##############
############## Load in the dataset
##############
# unzip the original data zip file
zip_path = "~/Desktop/Winter Quarter 2019/STA 141C/hw1/awards.zip"
all_files = unzip(zip_path, list = TRUE)
head(all_files)

# extract only needed files  
files = all_files[-1,]                     # delete 0.csv which is in the first row
# same: files = all_files[2:dim(all_files[1])[1],]
head(files)

# double check if 0.csv is removed by checking dimensions
dim(all_files)
dim(files)                                 # 0.csv is removed

##############
############## This function inputs fname and returns the annual median dataframe for this agency
############## file size of the file and number of rows in the file
get_med = function(fname){
  unzip(zip_path, files = fname)
  file_size = file.size(fname)
  sub_csv = read.csv(fname)
  row_n = dim(sub_csv)[1]
  
  # extract useful cols and modify them
  data_csv = sub_csv[c("total_obligation", "period_of_performance_start_date")] 
  colnames(data_csv) = c("spending", "date") # change column names
  data_csv$date = as.Date(data_csv$date)     # convert to Date datatype 
  
  # extract the year from date and drop the date column
  data_csv$year = format(data_csv$date, "%Y")   
  data_csv$date = NULL
  
  # compute the sum annual spending for this agency
  sum_df = tapply(data_csv$spending, data_csv$year, sum, na.rm = TRUE)
  sum_df = as.data.frame(sum_df)      
  
  # find the median annual spending for this agency
  med_result = as.data.frame(median(sum_df$sum_df))
  
  # add file names to the result dataframes
  # note: strsplit(targetstr, whatasseparator)[[1]][1]
  med_result$file = as.numeric(strsplit(fname, "[.]")[[1]][1])
  
  # change col names of med_result
  colnames(med_result) = c("med_annual_spending", "file_code")
  
  # delete the file as I go
  unlink(fname) 
  
  # add file_size and row_n to med_result
  med_result$file_size = file_size
  med_result$row_n = row_n
  
  # return the results 
  med_result
}

##############
############## Get the dataframe we need
##############
# get the file names
names = as.array(files$Name)

# apply get_med function to get median annual spending for each agency
result_list = lapply(names, get_med)

# convert the list of dataframe into df by column names
library(dplyr)
df = bind_rows(result_list, .id = NULL)

##############
############## Q1:Computation
##############
# 1. Which agencies have the highest median annual spending?
max_spending = max(df$med_annual_spending)
max_index = which(df$med_annual_spending == max_spending)
target_agency = df[max_index,]$file_code
target_agency
# agency with id 1219 has the highest median annual spending

# 2. Qualitatively describe the distribution of median annual spending.
hist(df$med_annual_spending, breaks = 40, main = "Distribution of The Median Annual Spending", ylab = "Number of Agencies" , xlab = "Median Annual Spending")

# 3.Qualitatively describe the distribution of the logarithm of the median annual spending.
hist(log(df$med_annual_spending), breaks = 40, main = "Distribution of Logarithm of The Median Annual Spending", ylab = "Number of Agencies" , xlab = "Log of Median Annual Spending")

# 4.Is there a clear separation between agencies that spend a large amount of money, and those which spend less money?
plot(df$med_annual_spending, main = "Median Annual Spending of Agencies", xlab = "Agencies", ylab = "Median Annual Spending")


##############
############## Q2:Reflecting
##############
# 1. Qualitatively describe the distribution of the file sizes.
hist(df$file_size, breaks = 30, main = "Distribution of File Sizes", ylab = "Number of Files", xlab = "File Size")

# 2. How does the size of the file relate to the number of rows in that file?
plot(df$file_size~df$row_n, main = "Relationship Between file size and number of rows in files", xlab = "number of rows", ylab = "file size")
plot(df$file_size~df$row_n, main = "Relationship Between file size and number of rows in files (Without Outliers)", xlab = "number of rows", ylab = "file size", xlim = c(-1000,7500), ylim = c(0,1000000))

# 3. How long does it take to process all the data?
# continue time calculation
end_time = Sys.time()

running_time = end_time - start_time
running_time

# 4. 5. See Report.




