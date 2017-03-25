
library(igraph)

########生成无向网络
par(mfrow=c(2,2))
set.seed(12345)
G1<-graph.formula(A--B,B--C)
G1<-add.edges(G1,c(2,2))   
V(G1)$label.cex<-0.7     
E(G1)$label<-c("e1","e2","e3")   
E(G1)$curved<-TRUE   
vcount(graph=G1)   
ecount(graph=G1)   
plot(G1,main="G1：无向网络(多重图)",layout=layout.fruchterman.reingold(G1))
G1<-simplify(graph=G1) 


G2<-graph.empty(n=4,directed=FALSE)
V(G2)$name<-V(G2)$label<-LETTERS[1:4]  
G2<-add.edges(G2, c(1,4,1,2,2,4,2,3))
E(G2)$label<-c("e1","e2","e3","e4")
E(G2)$curved<-TRUE
V(G2)$label.cex<-0.7
plot(G2,main="G2：无向连通网络",layout=layout.fruchterman.reingold(G2))

G3<-graph.empty(n=9,directed=FALSE)
V(G3)$name<-V(G3)$label<-LETTERS[1:9]
G3<-add.edges(G3, c(1,2,1,3,2,3,4,5,4,6,4,7,5,6,5,7,8,9))
E(G3)$label<-c("e1","e2","e3","e4","e5","e6","e7","e8","e9")
G3<-set.vertex.attribute(G3,name="discrete", 
   value=c(FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE))  
V(G3)[discrete]$shape<-"circle"
V(G3)[!discrete]$shape<-"square"
G3<-set.vertex.attribute(G3,name="color",value=c("red","green","yellow"))
E(G3)$curved<-TRUE
V(G3)$label.cex<-0.7
is.connected(graph=G3)  
sapply(V(G3),FUN=subcomponent,graph=G3)   
plot(G3,main="G3：无向不连通网络",layout=layout.fruchterman.reingold(G3))

G4<-k.regular.game(no.of.nodes=10,k=9,directed=FALSE,multiple=FALSE) 
#G4<-graph.ring(n=10)
V(G4)$name<-V(G4)$label<-LETTERS[1:10]
V(G4)$label.cex<-0.7
plot(G4,main="G4：完备图",layout=layout.fruchterman.reingold(G4))

########生成有向网络
library(igraph)
par(mfrow=c(2,2))
set.seed(12345)
G5<-graph.formula(A+-B,B-+C)
V(G5)$label.cex<-0.7
E(G5)$label<-c("e1","e2")
E(G5)$curved<-TRUE
plot(G5,main="G5：简单有向网络",layout=layout.fruchterman.reingold(G5))

G6<-graph.empty(n=4,directed=TRUE)
V(G6)$name<-V(G6)$label<-LETTERS[1:4]
G6<-add.edges(G6, c(1,4,2,1,2,3,3,2,3,3))
E(G6)$label<-c("e1","e2","e3","e4","e5")
E(G6)$curved<-TRUE
V(G6)$label.cex<-0.7
is.mutual(graph=G6)  
plot(G6,main="G6：有向网络（有环存在互惠关系）",layout=layout.fruchterman.reingold(G6))

G7<-graph.empty(n=5,directed=TRUE)
V(G7)$name<-V(G7)$label<-LETTERS[1:5]
G7<-add.edges(G7, c(1,2,1,3,1,5,2,3,3,4,5,4))
E(G7)$label<-c("e1","e2","e3","e4","e5","e6")
E(G7)$curved<-TRUE
V(G7)$label.cex<-0.7
is.dag(graph=G7)   
plot(G7,main="G7：有向不循环网络（弱连通）",layout=layout.fruchterman.reingold(G7))

G8<-G7
E(G8)$weight<-c(0.5,0.5,0.8,0.1,0.7,0.2)   
E(G8)$width<-1
E(G8)[weight>0.5]$width<-3
is.weighted(graph=G8)   
E(G8)$label<-c(0.5,0.5,0.8,0.1,0.7,0.2)
plot(G8,main="G8：有向加权网络",layout=layout.circle,edge.width=E(G8)$width)

################生成2-模网络
library(igraph)
par(mfrow=c(2,2))
set.seed(12345)
G9<-graph.full.bipartite(2,4,directed=TRUE,mode="out")   
V(G9)[!V(G9)$type]$name<-V(G9)[!V(G9)$type]$label<-LETTERS[1:2]  
V(G9)[V(G9)$type]$name<-V(G9)[V(G9)$type]$label<-letters[1:4]
plot(G9,main="G9：完备的有向2-模网络",layout=layout.circle)

G10<-graph.bipartite(types=c(FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE,TRUE),
   edges=c(1,4,1,5,1,6,2,5,3,6,3,7,3,8),directed=FALSE)  
V(G10)[!V(G10)$type]$name<-V(G10)[!V(G10)$type]$label<-LETTERS[1:3] 
V(G10)[V(G10)$type]$name<-V(G10)[V(G10)$type]$label<-letters[1:5]
plot(G10,main="G10：无向2-模网络",layout=layout.circle)

####################网络的矩阵表示：邻接矩阵、关系矩阵、连接列表
adj.G2<-as.matrix(get.adjacency(graph=G2))  
adj.G7<-as.matrix(get.adjacency(graph=G7))   
adj.G8<-as.matrix(get.adjacency(graph=G8,attr="weight"))   

(get.incidence(graph=G10)) #G10(无向2-模)的关系矩阵
(get.incidence(graph=G9)) #G9(有向2-模)的关系矩阵

(G7.data.frame<-get.data.frame(x=G7,what="edges"))  

################网络的数据文件:依据邻接矩阵建立网络
library(igraph)
Data0<-read.table(file="购物篮数据.txt",header=TRUE,sep=",")
Data<-as.matrix(Data0[,-1:-7])
Data[1:5,1:10]  #浏览部分数据
Data.adj<- t(Data) %*% Data 
dim(Data.adj)   
colnames(Data.adj)<-colnames(Data)  
Data.adj[1:5,1:11]   
diag(Data.adj)<-0 
Basket.G<-graph.adjacency(adjmatrix=Data.adj,weight=TRUE,mode="undirected")  
set.seed(12345)
plot(Basket.G,main="商品的交叉购买网络",edge.width=E(Basket.G)$weight/1000*10,
  layout=layout.fruchterman.reingold(Basket.G))
