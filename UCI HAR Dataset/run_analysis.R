x_data_test<-read.table("test\\X_test.txt")
activity_test <- read.table("test\\y_test.txt")
subject_test<-read.table("test\\subject_test.txt")
x_mean_test <- rowMeans(x_data_test)
activity_test<-activity_test$V1
subject_test<-subject_test$V1
x_sd_test <- vector()
x_sd_test <- as.numeric(x_sd_test)
for(i in 1:length(x_mean_test))
{
  x_sd_test <- c(x_sd_test,sd(x_data_test[i,]))
}
x_data_train<-read.table("train\\X_train.txt")
activity_train <- read.table("train\\y_train.txt")
subject_train<-read.table("train\\subject_train.txt")
x_mean_train <- rowMeans(x_data_train)
activity_train<-activity_train$V1
subject_train<-subject_train$V1
x_sd_train <- vector()
x_sd_train <- as.numeric(x_sd_train)
for(i in 1:length(x_mean_train))
{
  x_sd_train <- c(x_sd_train,sd(x_data_train[i,]))
}
df_train <-data.frame("x.mean"=x_mean_train,"x.sd" = x_sd_train,"activity" = activity_train,"subject" = subject_train)
df_test <-data.frame("x.mean"=x_mean_test,"x.sd" = x_sd_test,"activity" = activity_test,"subject" = subject_test)
df<-rbind(df_train,df_test)
df$activity = as.factor(df$activity)
library(plyr)
levels(df$activity)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
df$subject<-as.factor(df$subject)
avg_mean <- tapply(df$x.mean,list(df$activity,df$subject),mean)
avg_sd <- tapply(df$x.sd,list(df$activity,df$subject),mean)
new_data <- list("avg.mean" = avg_mean,"avg.sd" = avg_sd)