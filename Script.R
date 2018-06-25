# Setting the Working Directory to my Data Wrangling Exercise 1
setwd("C:/Users/Anton/Desktop/Data Wrangling Exercise 1")

# 0:Loading CSV file as dataframe
my_df <- read.csv("refine_original.csv")

## 1:Cleaining up 'company' column
#Making each value lower case
my_df$company <- tolower(my_df$company)
# Putting in proper names
my_df$company <- gsub(".*\\ps$", "philips", my_df$company)
my_df$company <- gsub("^ak.*", "akzo", my_df$company)
my_df$company <- gsub("^uni.*", "unilever", my_df$company)

# 2:Separating Product Code and Number
library(tidyr)
my_df <- separate(my_df, Product.code...number, c("product_code", "product_number"), "-")

# 3:Adding Product Categories
my_df$product_category <- my_df$product_code
my_df$product_category <- gsub("p", "Smartphone", my_df$product_category)
my_df$product_category <- gsub("v", "TV", my_df$product_category)
my_df$product_category <- gsub("x", "Laptop", my_df$product_category)
my_df$product_category <- gsub("q", "Tablet", my_df$product_category)

#4:Adding Full Address
my_df <- unite(my_df, full_address, address, city, country, sep = ",")

#5:Creating Dummy Variables
library(dplyr)
my_df <- mutate(my_df, company_philips = ifelse(company == "philips", 1, 0))
my_df <- mutate(my_df, company_akzo = ifelse(company == "akzo", 1, 0))
my_df <- mutate(my_df, company_van_houten = ifelse(company == "van houten", 1, 0))
my_df <- mutate(my_df, company_unilever = ifelse(company == "unilever", 1, 0))
my_df <- mutate(my_df, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
my_df <- mutate(my_df, product_laptop = ifelse(product_category == "Laptop", 1, 0))
my_df <- mutate(my_df, product_tv = ifelse(product_category == "TV", 1, 0))
my_df <- mutate(my_df, product_tablet = ifelse(product_category == "Tablet", 1, 0))

##Saving Dataframe as CSV
write.csv(my_df, "refine_clean.csv")

