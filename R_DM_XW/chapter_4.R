set.seed(1)#设定随机数种子
x1<-runif(60,-1,1)#从-1到1之间产生60个均匀分布的随机数  
x2<-runif(60,-1,1)  
y<-sample(c(0,1),size=60,replace=TRUE,prob=c(0.3,0.7))#随机指定类别标签，0为0.3，1为0.7   
Data<-data.frame(Fx1=x1,Fx2=x2,Fy=y)#将观测值制成data.frame
SampleId<-sample(x=1:60,size=18)#在[1,60]中随机抽取18个索引值  
DataTest<-Data[SampleId,] #测试集为18个值  
DataTrain<-Data[-SampleId,]  #训练集为42个值

#绘制观测样本图
par(mfrow=c(2,2),mar=c(4,6,4,4))#设置图形布局，mfrow=c(行数，列数),mar=c(下，左，上，右)
plot(Data[,1:2],pch=Data[,3]+1,cex=0.8,xlab="x1",ylab="x2",main="全部样本")#pch类型，cex大小
plot(DataTrain[,1:2],pch=DataTrain[,3]+1,cex=0.8,xlab="x1",ylab="x2",main="训练样本和测试样本")
points(DataTest[,1:2],pch=DataTest[,3]+16,col=2,cex=0.8)

#加载class包
library("class")
errRatio<-vector()#全部观测的错判向量   
for(i in 1:30){ #近邻参数K从1取到30   
 KnnFit<-knn(train=Data[,1:2],test=Data[,1:2],cl=Data[,3],k=i)#训练集和测试集相同
 CT<-table(Data[,3],KnnFit)  #计算混淆矩阵
 errRatio<-c(errRatio,(1-sum(diag(CT))/sum(CT))*100)     
}
plot(errRatio,type="l",xlab="近邻个数K",ylab="错判率(%)",main="近邻数K与错判率",ylim=c(0,80))

errRatio1<-vector()   
for(i in 1:30){
 KnnFit<-knn(train=DataTrain[,1:2],test=DataTest[,1:2],cl=DataTrain[,3],k=i) #划分成训练集和测试集之后
 CT<-table(DataTest[,3],KnnFit) 
 errRatio1<-c(errRatio1,(1-sum(diag(CT))/sum(CT))*100)    
}
lines(1:30,errRatio1,lty=2,col=2)

set.seed(1)
errRatio2<-vector() #留一法错判向量  
for(i in 1:30){   
 KnnFit<-knn.cv(train=Data[,1:2],cl=Data[,3],k=i) #留一法交叉验证
 CT<-table(Data[,3],KnnFit)  
 errRatio2<-c(errRatio2,(1-sum(diag(CT))/sum(CT))*100)     
}
lines(1:30,errRatio2,col=2)

##############KNN回归
set.seed(1)
x1<-runif(60,-1,1)  
x2<-runif(60,-1,1)  
y<-runif(60,10,20)   
Data<-data.frame(Fx1=x1,Fx2=x2,Fy=y)
SampleId<-sample(x=1:60,size=18)  
DataTest<-Data[SampleId,]  
DataTrain<-Data[-SampleId,]  
mseVector<-vector()    
for(i in 1:30){
 KnnFit<-knn(train=DataTrain[,1:2],test=DataTest[,1:2],cl=DataTrain[,3],k=i,prob=FALSE) 
 KnnFit<-as.double(as.vector(KnnFit))   #回归结果为因子向量，需转换成数值向量
 mse<-sum((DataTest[,3]-KnnFit)^2)/length(DataTest[,3])   #计算均方误差
 mseVector<-c(mseVector,mse)
}
plot(mseVector,type="l",xlab="近邻个数K",ylab="均方误差",main="近邻数K与均方误差",ylim=c(0,80))

##############天猫成交顾客的分类预测
library("class") 
Tmall_train<-read.table(file="天猫_Train_1.txt",header=TRUE,sep=",")
head(Tmall_train)
Tmall_train$BuyOrNot<-as.factor(Tmall_train$BuyOrNot)
Tmall_test<-read.table(file="天猫_Test_1.txt",header=TRUE,sep=",")
Tmall_test$BuyOrNot<-as.factor(Tmall_test$BuyOrNot)
set.seed(123456)
errRatio<-vector()   
for(i in 1:30){
 KnnFit<-knn(train=Tmall_train[,-1],test=Tmall_test[,-1],cl=Tmall_train[,1],k=i,prob=FALSE) 
 CT<-table(Tmall_test[,1],KnnFit) 
 errRatio<-c(errRatio,(1-sum(diag(CT))/sum(CT))*100)    
}
plot(errRatio,type="b",xlab="近邻个数K",ylab="错判率(%)",main="天猫成交顾客分类预测中的近邻数K与错判率")

####天猫数据KNN分类讨论变量重要性
library("class")  
par(mfrow=c(2,2))
set.seed(123456)
errRatio<-vector()   
for(i in 1:30){
 KnnFit<-knn(train=Tmall_train[,-1],test=Tmall_test[,-1],cl=Tmall_train[,1],k=i,prob=FALSE) 
 CT<-table(Tmall_test[,1],KnnFit) 
 errRatio<-c(errRatio,(1-sum(diag(CT))/sum(CT))*100)    
}
plot(errRatio,type="l",xlab="近邻个数K",ylab="错判率(%)",main="近邻数K与错判率")
errDelteX<-errRatio[7]
for(i in -2:-5){
 fit<-knn(train=Tmall_train[,c(-1,i)],test=Tmall_test[,c(-1,i)],cl=Tmall_train[,1],k=7)
 CT<-table(Tmall_test[,1],fit)
 errDelteX<-c(errDelteX,(1-sum(diag(CT))/sum(CT))*100)
}
plot(errDelteX,type="l",xlab="剔除变量",ylab="剔除错判率(%)",main="剔除变量与错判率(K=7)",cex.main=0.8)
xTitle=c("1:全体变量","2:消费活跃度","3:活跃度","4:成交有效度","5:活动有效度")
legend("topright",legend=xTitle,title="变量说明",lty=1,cex=0.6)   
FI<-errDelteX[-1]+1/4   
wi<-FI/sum(FI)       
GLabs<-paste(c("消费活跃度","活跃度","成交有效度","活动有效度"),round(wi,2),sep=":")
pie(wi,labels=GLabs,clockwise=TRUE,main="输入变量权重",cex.main=0.8)
ColPch=as.integer(as.vector(Tmall_test[,1]))+1
plot(Tmall_test[,c(2,4)],pch=ColPch,cex=0.7,xlim=c(0,50),ylim=c(0,50),col=ColPch,
     xlab="消费活跃度",ylab="成交有效度",main="二维特征空间中的观测",cex.main=0.8)

############天猫数据加权KNN分类
install.packages("kknn")
library("kknn")
par(mfrow=c(2,1))
Tmall_train<-read.table(file="天猫_Train_1.txt",header=TRUE,sep=",")
Tmall_train$BuyOrNot<-as.factor(Tmall_train$BuyOrNot)
fit<-train.kknn(formula=BuyOrNot~.,data=Tmall_train,kmax=11,distance=2,kernel=c("rectangular","triangular","gaussian"),na.action=na.omit())
plot(fit$MISCLASS[,1]*100,type="l",main="不同核函数和近邻个数K下的错判率曲线图",cex.main=0.8,xlab="近邻个数K",ylab="错判率(%)")
lines(fit$MISCLASS[,2]*100,lty=2,col=1)
lines(fit$MISCLASS[,3]*100,lty=3,col=2)
legend("topleft",legend=c("rectangular","triangular","gaussian"),lty=c(1,2,3),col=c(1,1,2),cex=0.7)   #给出图例

Tmall_test<-read.table(file="天猫_Test_1.txt",header=TRUE,sep=",")
Tmall_test$BuyOrNot<-as.factor(Tmall_test$BuyOrNot)
fit<-kknn(formula=BuyOrNot~.,train=Tmall_train,test=Tmall_test,k=7,distance=2,kernel="gaussian",na.action=na.omit())
CT<-table(Tmall_test[,1],fit$fitted.values)
errRatio<-(1-sum(diag(CT))/sum(CT))*100

library("class")
fit<-knn(train=Tmall_train,test=Tmall_test,cl=Tmall_train$BuyOrNot,k=7)
CT<-table(Tmall_test[,1],fit)
errRatio<-c(errRatio,(1-sum(diag(CT))/sum(CT))*100)
errGraph<-barplot(errRatio,main="加权K近邻法与K近邻法的错判率对比图(K=7)",cex.main=0.8,xlab="分类方法",ylab="错判率(%)",axes=FALSE)
axis(side=1,at=c(0,errGraph,3),labels=c("","加权K-近邻法","K-近邻法",""),tcl=0.25)
axis(side=2,tcl=0.25)


