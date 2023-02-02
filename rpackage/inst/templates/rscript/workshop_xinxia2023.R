library(foreign)
library(dplyr)
library(haven)
library(tidyr)


#### 1. loop basics ####
#### 1.1. loop over numbers #### 
for (i in 1:5){
  print(i)
}

for (i in c(1,3:5)){
  print(i)
}

for (i in c(1,3,5)){
  print(i)
}

#extra codes to try out
for (i in seq(from=1,to=10,by=2)){
  print(i)
}

#extra codes to try out: use if else in a loop
for (i in 1:5){
  if(i<3){NULL}
  else{print(i)}
}

#extra codes to try out: use if else in a loop
for (i in 1:10){
  if(i<2){NULL}
  else if(i>=3&i<8){print(i+1)}
  else{print(i)}
}


#### 1.2. loop over strings #### 
for (i in c("apple","orange","flower","bee")){
  print(i)
}

#another way to generate the same output
random_stuff<-c("apple","orange","flower","bee")
length(random_stuff)
for (i in 1:length(random_stuff)){
  print(random_stuff[[i]])
}

#another way to generate the same output
for (i in random_stuff){
  print(i)
}


#### 1.3 loop over list ####
num_list<-list(runif(50),runif(40),runif(30))
length(num_list)
for (i in 1:length(num_list)){
  print(num_list[[i]])
  print(mean(num_list[[i]]))
}





#### 2. apply ####
#apply-for data frame/matrix
apply(matrix(1:8,nrow=2), 1, mean)
apply(matrix(1:8,nrow=2), 1, sum)
apply(matrix(1:8,nrow=2), 1, max)


#lapply-for list
lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), mean)

unlist(lapply(list(a=matrix(1:8,nrow=2),
                   b=matrix(1:9,nrow=3)), mean))

lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) x-2)

lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) x/3)

lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) round(x/3,digits = 0))


#sapply-for data frame/vector/list
sapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), mean)

sapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) round(x/3,digits = 0))


#mapply-for multiple list or vector
mapply(rep,1:4,4:1)
unlist(mapply(rep,1:4,4:1))


#tapply-subset of objects

fake_data <- read_dta("fake data.dta")
tapply(fake_data$mmse_wave1, fake_data$sex, mean, na.rm=TRUE)
tapply(fake_data$mmse_wave1, list(fake_data$sex,fake_data$education), mean, na.rm=TRUE)



#### 3. generate variables with loop ####
#generate an empty data frame with 500 rows
data_ex2<-data.frame(matrix(nrow = 500))[-1]
#generate random numbers as values of each variable
for (i in c("A","B","C")){
  for (j in 0:4){
    data_ex2[[paste0(i,j)]]<-runif(500)
  }
}

#extra codes to try out: summarize summary statistics
colnames(data_ex2)
for (i in 1:length(colnames(data_ex2))){
  print(mean(data_ex2[[i]]))
  print(mean(data_ex2[[colnames(data_ex2)[i]]]))
  print(sd(data_ex2[[i]]))
  print(sd(data_ex2[[colnames(data_ex2)[i]]]))
}


#extra codes to try out: generate new variable with values equal to row mean of A_/B_/C_
for (a in c("A","B","C")){
  data_ex2[[paste0("M1_",a)]]<-rowMeans(data_ex2[,grepl(a,names(data_ex2))])
  #alternative to generate row mean
  data_ex2[[paste0("M2_",a)]]<-apply(data_ex2[,grepl(a,names(data_ex2))],1,mean)
}

#### 4. generate an empty data frame with four variables ####
data_ex1<-data.frame(ID=numeric(0),sex=numeric(0),age=numeric(0),city=character(0))
#use loop and rbind to assign values to the data frame
id<-c(1:5)
sex<-c(1,1,2,2,1)
age<-c(50,51,60,55,58)
city<-c("kungsholmen","uppsala","kungsholmen","kungsholmen","uppsala")
for (i in 1:5){
      temp_data_ex1<-data.frame(ID=id[[i]],sex=sex[[i]],age=age[[i]],city=city[[i]])
      data_ex1<-rbind(data_ex1,temp_data_ex1)
}


#Alternative: use function to assign values to the data frame
data_ex1_fun<-function(id,sex,age,city){
  temp_data_ex1<-data.frame(ID=id,sex=sex,age=age,city=city)
  data_ex1<-rbind(data_ex1,temp_data_ex1)
}

data_ex1<-data_ex1_fun(id=6,sex=2,age=45,city="uppsala")
data_ex1<-data_ex1_fun(id=7,sex=1,age=65,city="uppsala")


#### 5. loops over models ####
#### 5.1. use loop to run linear regression with different sets of covariates ####
cov_list<-c("age_base","age_base+sex","age_base+sex+education")
for (i in 1:length(cov_list)){
  print(summary(glm(formula = as.formula(paste0("mmse_wave1~",cov_list[[i]])),family = "gaussian",data = fake_data)))
}


#### 5.2. use loop to run linear regression with different datasets ####
#combine datasets to a list
data_list<-list(subset(fake_data,sex==0),subset(fake_data,sex==1))
names(data_list)<-c("fake_data_male","fake_data_female")
cov_list2<-c("age_base","age_base+education")

for (i in 1:length(cov_list2)){
  for (j in 1:length(data_list)){
    print(summary(glm(formula = as.formula(paste0("mmse_wave1~",cov_list2[[i]])),family = "gaussian",data = data_list[[j]])))
  }
}

#Alternative: use function to run models with different covariates through datasets
lm_exa<-lapply(cov_list2,function(i){
  lapply(data_list,function(j){
    print(summary(glm(formula = as.formula(paste0("mmse_wave1~",i)),family = "gaussian",data = j)))
  })
})



#### 5.3. use loop to summarize results from statistical models ####
#run a single model
model_exe<-glm(formula = mmse_wave1~age_base+sex+education,family = "gaussian",data = fake_data)

#summarize model
summary(model_exe)
summary(model_exe)$coefficients
class(summary(model_exe)$coefficients)
row.names(summary(model_exe)$coefficients)
summary(model_exe)$coefficients[2,1]

#get confidence interval
confint(model_exe)
class(confint(model_exe))
row.names(confint(model_exe))


#create an empty data frame
lm_results<-data.frame(model=character(0),dataset=character(0),predictor=character(0),
                       estimates=numeric(0),lb=numeric(0),ub=numeric(0),p_value=numeric(0))
for (i in 1:length(cov_list2)){
  for (j in 1:length(data_list)){
    temp_model<-glm(formula = as.formula(paste0("mmse_wave1~",cov_list2[[i]])),family = "gaussian",data = data_list[[j]])
    for (n in 1:length(row.names(summary(temp_model)$coefficients))){
      model<-paste("Model",i,sep = " ")
      dataset<-names(data_list[j])
      predictor<-row.names(summary(temp_model)$coefficients)[n]
      estimates<-round(summary(temp_model)$coefficients[n,1],digits = 2)
      p_value<-round(summary(temp_model)$coefficients[n,4],digits = 3)
      lb<-round(confint(temp_model)[n,1],digits = 2)
      ub<-round(confint(temp_model)[n,2],digits = 2)
      temp_results<-data.frame(model=model,dataset=dataset,predictor=predictor,
                               estimates=estimates,lb=lb,ub=ub,p_value=p_value)
      lm_results<-rbind(lm_results,temp_results)
    }
  }
}

#concatenate point estimates, lower bound and upper bound of the confidence interval
#note: this can be done inside loop too
lm_results$point_ci<-paste0(lm_results$estimates," (",lm_results$lb,",",lm_results$ub,")")
lm_results$point_ci2<-paste0(lm_results$estimates," (",lm_results$lb,"-",lm_results$ub,")")
lm_results$p_value<-ifelse(lm_results$p_value<0.0001,"<0.0001",lm_results$p_value)


write.csv(lm_results, "lm_results.csv")
