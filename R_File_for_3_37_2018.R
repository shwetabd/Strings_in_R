## manipulating the data with String R 

library(stringr)

#1 create the char string tht contins just one quation mark "


print("\"")
cat("\"")   ## Cat is actaully correct way to print

cat("DSO\n545") ## \n is used for new line

cat("DSO\t545") ## \t is for new tab

#2 Create the folowwing in R

# :-\

cat(":-\\")
cat("^_^\"")
cat("@_\'-\'")
cat("\\m/")


# 3 Load String R pkg, and search for str_locate() and str_sub()


?str_locate
?str_all
?str_sub

#4 Locate the char "a", "great", "fantastic", and "super"super"

a_find_1 = str_locate(string="great", pattern = "a")
a_find_2 = str_locate(string="fantastic", pattern = "a")
a_find_2_1 = str_locate_all(string="fantastic", pattern = "a")
a_find_3 = str_locate(string="super", pattern = "a")

## better way to do..put in vector

a_find = str_locate(c("great", "fantastic","super"), "a")


#5 print below substring from "testing"

str_sub("testing",str_locate("testing","tes"))
str_sub("testing", start=1, end=3)

str_sub("testing",str_locate("testing", "ting"))
str_sub("testing",str_locate("testing","test"))

#6 What do you think code is doing..
#ans: 
## Telling input string to start @ position 2 and for 2nd string telling start @ 3rd position

input <- c("abc", "defg")
str_sub(input, c(2,3))  


#7 : use str_locate to find header and body

email_data <- readRDS("email.rds")

# look email sub1

email_data[1]
cat(email_data[1])  ## read email better

locate_email_sepration=str_locate(email_data[1],"\n\n")

## Extarct the body and header of 1st email

email1_header = str_sub(email_data[1],0,842)
email1_body = str_sub(email_data[1],844, str_length(email_data[1]))

cat(email1_header)
cat(email1_body)

## another way to do..use start and end by porgrm only

email1_header = str_sub(email_data[1],0,locate_email_sepration[1])
email1_body = str_sub(email_data[1],locate_email_sepration[2], str_length(email_data[1]))

cat(email1_header)
cat(email1_body)




##10 : use all header and body in two files for all 200 records
locate_email_sepration_200 = str_locate(email_data, "\n\n")

email1_header_200 = str_sub(email_data,
                            start=,
                            end=locate_email_sepration_200[,1])

email1_body_200 = str_sub(email_data,
                          start=locate_email_sepration_200[,2])
                    

cat(email1_header_200)
cat(email1_body_200)

## print body for number 6
cat(email1_body_200[6])















###################### Regular expression ############3



#1 : 
fruit = c("apple", "banana","pear","pinapple")

#2 detects if pttern is found

str_detect(fruit, "a")

#pattern start with a
str_detect(fruit, "^a")

## pattern ends with a
str_detect(fruit, "a$")


##patern to check if it has a, e, o,u or i
str_detect(fruit,"[aeiou]")

# check anything between a to d 
str_detect(fruit,"[a-d]")

## does str has any alfa
str_detect(fruit,"[a-z]")

## does str has any numeric
str_detect(fruit,"[0-9]")


# 3 > start with a and ends with e


str_detect(fruit,"^a[a-z]*e$") 
#or  ... Imp : you are weak at this.
str_detect(fruit,"^a.*e$")  ### . means any char and * varaible with 1 or more value

#4 detect the phone number

phone = "213 472 4782"
str_detect(phone, "[0-9]{3} [0-9]{3} [0-9]{4}" )

phone_v = c("213 472 4782","213-890-8901","6788901879", "(217) 325 6789")
str_detect(phone_v, "[0-9]{3}.*[0-9]{3}.*[0-9]{4}" )
#or prof way .. the 1st parathis comes before number and optional
str_detect(phone_v, "[(]?[0-9]{3}[)]?[ -][0-9]{3}[ -][0-9]{4}" )

## find number in bodies
str_detect(email1_body_200, "[(]?[0-9]{3}[)]?[ -][0-9]{3}[ -][0-9]{4}" )




