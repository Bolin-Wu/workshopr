## ---------------------------------------------------------------------------------------------
install.packages("remotes")
remotes::install_github("Bolin-Wu/workshopr", subdir = "rpackage", force = TRUE)


## ---------------------------------------------------------------------------------------------
library(workshopr)


## ---------------------------------------------------------------------------------------------
dem_dat = workshopr::fake_data


## ---------------------------------------------------------------------------------------------
for (i in 1:5){
  print(i)
}



## ---------------------------------------------------------------------------------------------
for (a in c(1,3:5)){
  print(a)
}



## ---------------------------------------------------------------------------------------------
for (i in seq(from=2,to=15,by=2)){
  print(i)
}



## ---------------------------------------------------------------------------------------------
#with if else
for (i in 1:5){
  if(i<3){NULL} 
  else{print(i)}
}



## ---------------------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------------------
for (i in 1:10){
  if(i<2){NULL}
  else if(i>=3&i<8){print(i+1)}
  else{print(i)}
}



## ---------------------------------------------------------------------------------------------
for (i in c("apple","orange","flower","bee")){
  print(i)
}


## ---------------------------------------------------------------------------------------------
random_stuff<-c("apple","orange","flower","bee")
length(random_stuff)
random_stuff[3]


## ---------------------------------------------------------------------------------------------
for (i in 1:length(random_stuff)){
  print(random_stuff[[i]])
}

#or

for (i in random_stuff){
  print(i)
}


## ---------------------------------------------------------------------------------------------
for (i in colnames(dem_dat)){
  if(grepl("wave5", i, fixed=TRUE)){print(i)}
  else{NULL}
}


## ---------------------------------------------------------------------------------------------
mat_dat = matrix(1:8, nrow=2)
mat_dat


## ---------------------------------------------------------------------------------------------
apply(mat_dat, 1, mean)
apply(mat_dat, 1, sum)
apply(mat_dat, 1, max)


## ---------------------------------------------------------------------------------------------
apply(mat_dat, 2, mean)
apply(mat_dat, 2, sum)
apply(mat_dat, 2, max)


## ---------------------------------------------------------------------------------------------
lapply(list(a = matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), mean)



## ---------------------------------------------------------------------------------------------
unlist(lapply(list(a=matrix(1:8,nrow=2),
                   b=matrix(1:9,nrow=3)), mean))



## ---------------------------------------------------------------------------------------------
lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) x-2)


## ---------------------------------------------------------------------------------------------
lapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) round(x/3,digits = 0))


## ---------------------------------------------------------------------------------------------
sapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), mean)


## ---------------------------------------------------------------------------------------------
sapply(list(a=matrix(1:8,nrow=2),
            b=matrix(1:9,nrow=3)), function(x) round(x/3,digits = 0))


## ---------------------------------------------------------------------------------------------

sapply(dem_dat[,grepl("mmse", colnames(dem_dat))], 
       function(x) mean(x, na.rm =T))



## ---------------------------------------------------------------------------------------------
for (i in colnames(dem_dat[,grepl("mmse", colnames(dem_dat))])){
  print(i)
  print(mean(dem_dat[[i]], na.rm = T))
  print(median(dem_dat[[i]], na.rm = T))
}



## ---------------------------------------------------------------------------------------------
mapply(rep,1:4,4:1)



## ---------------------------------------------------------------------------------------------
unlist(mapply(rep,1:4,4:1))


## ---------------------------------------------------------------------------------------------
vec1 = c(600, 5, 30, 9)
vec2 = c(300, 6000, 9000, 2)
mapply(max, vec1, vec2)


## ---------------------------------------------------------------------------------------------
#tapply-subset of objects

tapply(dem_dat$mmse_wave1, dem_dat$sex, mean, na.rm=TRUE)
tapply(dem_dat$mmse_wave1, list(dem_dat$sex,dem_dat$education), mean, na.rm=TRUE)



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------
#generate an empty data frame with 500 rows
data_ex2<-data.frame(matrix(nrow = 500))[-1]
#generate random numbers as values of each variable
for (i in c("A","B","C")){
  for (j in 0:4){
    data_ex2[[paste0(i,j)]]<-runif(500)
  }
}

head(data_ex2)


## ---------------------------------------------------------------------------------------------

for (i in colnames(dem_dat[,grepl("age", colnames(dem_dat))])){
  print(i)
  print("mean")
  print(mean(dem_dat[[i]], na.rm = T))
  print("median")
  print(median(dem_dat[[i]], na.rm = T))
  print("min")
  print(min(dem_dat[[i]], na.rm = T))
  print("max")
  print(max(dem_dat[[i]], na.rm =T))
}



## ---------------------------------------------------------------------------------------------
sum_dat = data.frame(wave_num = as.character(),
                     mean = as.numeric(),
                     median = as.numeric(),
                     min = as.numeric(),
                     max = as.numeric(),
                     stringsAsFactors = F)


## ---------------------------------------------------------------------------------------------

for(i in colnames(dem_dat[,grepl("age", colnames(dem_dat))])) {
  # creating a vector to append
  # to data frame
  
  vec <- c(i, 
           mean(dem_dat[[i]], na.rm = T), 
           median(dem_dat[[i]], na.rm = T),
           min(dem_dat[[i]], na.rm = T),
           max(dem_dat[[i]], na.rm = T))
  
  # assigning this vector to ith row
  sum_dat[nrow(sum_dat)+1,] <- vec
  
  #make values numeric 
  sum_dat[,2:5] <- sapply(sum_dat[,2:5],as.numeric)
}
sum_dat


## ---------------------------------------------------------------------------------------------
barplot(sum_dat$mean,names.arg=sum_dat$wave_num,xlab="Wave",ylab="Mean",col="blue",
        main="Mean age of participants")



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------
cov_list<-c("age_base","age_base+sex","age_base+sex+education")
for (i in 1:length(cov_list)){
  print(summary(glm(formula = as.formula(paste0("mmse_wave5~",cov_list[[i]])),family = "gaussian",data = dem_dat)))
}



## ---------------------------------------------------------------------------------------------
#combine datasets to a list
data_list<-list(subset(dem_dat,sex==0),subset(dem_dat,sex==1))
names(data_list)<-c("dem_dat_female","dem_dat_male")
cov_list2<-c("age_base","age_base+education")

for (i in 1:length(cov_list2)){
  for (j in 1:length(data_list)){
    print(summary(glm(formula = as.formula(paste0("mmse_wave5~",cov_list2[[i]])),family = "gaussian",data = data_list[[j]])))
  }
}


## ---------------------------------------------------------------------------------------------
#Alternative: use function to run models with different covariates through datasets
lm_exa<-lapply(cov_list2,function(i){
  lapply(data_list,function(j){
    print(summary(glm(formula = as.formula(paste0("mmse_wave5~",i)),family = "gaussian",data = j)))
  })
})



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------
model_exe<-glm(formula = mmse_wave1~age_base+sex+education,family = "gaussian",data = dem_dat)



## ---------------------------------------------------------------------------------------------
summary(model_exe)
summary(model_exe)$coefficients
class(summary(model_exe)$coefficients)
row.names(summary(model_exe)$coefficients)
summary(model_exe)$coefficients[2,1]


## ---------------------------------------------------------------------------------------------
confint(model_exe)
class(confint(model_exe))
row.names(confint(model_exe))



## ---------------------------------------------------------------------------------------------
lm_results<-data.frame(model=character(0),dataset=character(0),predictor=character(0),estimates=numeric(0),lb=numeric(0),ub=numeric(0),p_value=numeric(0))


## ---------------------------------------------------------------------------------------------

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



## ---------------------------------------------------------------------------------------------
lm_results$point_ci<-paste0(lm_results$estimates," (",lm_results$lb,",",lm_results$ub,")")
lm_results$point_ci2<-paste0(lm_results$estimates," (",lm_results$lb,"-",lm_results$ub,")")
lm_results$p_value<-ifelse(lm_results$p_value<0.0001,"<0.0001",lm_results$p_value)

lm_results




## ---------------------------------------------------------------------------------------------


