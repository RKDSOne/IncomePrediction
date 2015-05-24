library(stringr)
library(caret)
library(rpart)
library(randomForest)

set.seed(2015)

train = read.csv("Data/adult.data")
test = read.csv("Data/adult.test")

names(train) = c("age", "workclass", "fnlwgt", 
                "education", "education.number", "marital.status", 
                "occupation", "relationship", "race", 
                "sex", "capital.gain", "capital.loss",
                "hour.per.week", "country", "income")

names(test) = names(train)
train$income = factor(train$income, labels=c("<=50K", ">50K"))
test$income = factor(test$income, labels=c("<=50K", ">50K"))

all = rbind(train, test)
all$country = str_trim(all$country)
all = subset(all, country == "United-States", select=-c(capital.gain, capital.loss, fnlwgt, education.number))
all = subset(all, select=-c(country))
levels(all$workclass) = c("Other", "Federal Government", "Local Government", 
                          "Never Worked", "Private", "Self-employed Incorporated", 
                          "Self-employed Not Incorporated", "State Government", 
                          "Without Pay")
levels(all$education) = c("10th", "11th", "12th",
                          "1st-4th", "5th-6th", "7th-8th",
                          "9th", "Associate Academic", "Associate Vocational",
                          "Bachelors", "Doctorate", "High School", 
                          "Masters", "Preschool", "Professional School", 
                          "College")
levels(all$marital.status) = c("Divorced", "Married", "Married",
                          "Married Spouse Absent", "Never Married", "Separated", 
                          "Widowed")
levels(all$occupation) = c("Other", "Administrative Clerical", "Armed Forces",
                           "Craft Repair", "Executive Managerial", "Farming",
                           "Cleaners", "Machine Operators", "Other Service Industry",
                           "Private House Service", "Specialty Professional", "Protective Services",
                           "Sales", "Tech Support", "Transport")
levels(all$relationship) = c("Husband", "Not in Family", "Other Relative", 
                             "Own Child", "Unmarried", "Wife")
levels(all$race) = c("American Indian", "Asia Pacific Islander", "African American", 
                     "Other", "Caucasian")
levels(all$sex) = c("Female", "Male")

#write.csv(all, file="Data/CleanData.csv", row.names=FALSE)

trainIndex = createDataPartition(all$income, p=0.8, list=FALSE) 
trn = all[trainIndex,]
val = all[-trainIndex,]

fitControl = trainControl(method = "cv", number = 10)
fit = train(income~., data=trn, method="rf", trControl = fitControl, importance=TRUE)
prp = predict(fit, newdata=val)
save(fit, file="Scripts/fit.obj")
confusionMatrix(prp, val$income)

newdata=data.frame(age=23, workclass="Private", education="Bachelors", 
                   marital.status="Never Married", occupation="Administrative Clerical",
                   relationship="Own Child", race="Caucasian", sex="Female",
                   hour.per.week=30)
x = predict(fit, newdata=newdata)

x$crace = ifelse(x$race=="Caucasian" & x$income=="<=50K", TRUE, FALSE)
x$cage = ifelse(x$age==35 & x$income==">50K", TRUE, FALSE)
ggplot(x, aes(x=race, fill=income, alpha=crace)) + geom_bar(position="fill") + theme_bw() + scale_alpha_discrete(range=c(0.1, 1), guide=FALSE) + coord_flip()
ggplot(x, aes(x=age, fill=income, alpha=cage)) + geom_bar(position="fill", binwidth=1) + theme_bw() + scale_alpha_discrete(range=c(0.6, 1), guide=FALSE) +coord_flip()
