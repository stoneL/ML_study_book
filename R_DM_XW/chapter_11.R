install.packages("arules")
install.packages("arulesViz")

library("arules")

###########生成transactoins对象：方式一
MyList<-list(   
  c("A","C","D"),
  c("B","C","E"),
  c("A","B","C","E"),
  c("B","E")
)
names(MyList)<-paste("Tr",c(1:4),sep="")
MyTrans<-as(MyList,"transactions")
summary(MyTrans)
inspect(MyTrans)
image(MyTrans)

###########生成transactoins对象：方式二
MyFact<-matrix(c(
      1,0,1,1,0,
	0,1,1,0,1,
	1,1,1,0,1,
	0,1,0,0,1
  ),nrow=4,ncol=5,byrow=TRUE)
dimnames(MyFact)<-list(paste("Tr",c(1:4), sep = ""),c("A","B","C","D","E"))
MyFact
(MyTrans<-as(MyFact,"transactions"))
(as(MyTrans,"data.frame"))

###########生成transactoins对象：方式三
MyT<-data.frame(
  TID=c(1,1,1,2,2,2,3,3,3,3,4,4), 
  items=c("A","C","D","B","C","E","A","B","C","E","B","E")
  )
(MyList<-split(MyT[,"items"],MyT[,"TID"]))
(MyTrans<-as(MyList,"transactions"))

###########生成transactoins对象：方式四
MyTrans<-read.transactions(file="事务原始数据.txt",format="basket",sep=",")
MyTrans<-read.transactions(file="事务表数据.txt",format="single",cols=c("TID","ITEMS"),sep="	")
