install.packages("kohonen")
library("kohonen")
set.seed(12345)
Data<-matrix(rnorm(n=100,mean=0,sd=1),ncol=2,byrow=TRUE)  
Data[1:25,1]<-Data[1:25,1]+3            
Data[1:25,2]<-Data[1:25,2]-4
set.seed(12345)
My.som<-som(data=Data,grid=somgrid(xdim=1,ydim=2,topo="rectangular"),n.hood="circular")
summary(My.som)           #mean(My.som$distances)
table(My.som$unit.classif)
par(mfrow=c(2,2))
plot(Data,main="模拟数据观测点的分布",xlab="x1",ylab="x2")  
plot(My.som,type="mapping",main="SOM网络输出层示意图",pchs=My.som$unit.classif)
plot(My.som,type="changes",main="SOM网络聚类评价图")
plot(My.som$data,pch=My.som$unit.classif,main="模拟数据SOM网络聚类结果",xlab="x1",ylab="x2")
points(My.som$code,col=2,pch=10)     
My.som$code   
