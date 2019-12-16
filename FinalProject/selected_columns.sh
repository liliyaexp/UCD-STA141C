# get data
CSVFILE=/scratch/transaction.csv

# obtain the needed col indexes from colname_index.txt
# action_date: 3
# last_modified_date: 4
# total_obligation: 8
# awarding_agency_id: 17
# pop_country_code: 27
# pop_country_name: 28
# recipient_location_country_code: 34
# recipient_location_country_name: 35
# recipient_location_state_code: 36
# recipient_name: 51
# awarding_toptier_agency_name: 53
# funding_toptier_agency_name: 54
# business_categories: 61


# extract needed cols
cat ${CSVFILE} | cut -d "," -f 3,4,8,17,27,28,34,35,36,51,53,54,61 > selected_columns.csv


# run these code in local mac command to
# upload the files to remote
# scp /Users/liliya/Desktop/Winter\ Quarter\ 2019/STA\ 141C/Final/submit1.sh s141c-23@gauss.cse.ucdavis.edu:/home/s141c-23/STA141C-HW5
# scp /Users/liliya/Desktop/Winter\ Quarter\ 2019/STA\ 141C/Final/selected_columns.sh s141c-23@gauss.cse.ucdavis.edu:/home/s141c-23/STA141C-HW5


# dowanload selected_columns.csv to local
#scp s141c-23@gauss.cse.ucdavis.edu:/home/s141c-23/STA141C-HW5/selected_columns.csv /Users/liliya/Desktop/Winter\ Quarter\ 2019/STA\ 141C/Final/selected_columns.csv

