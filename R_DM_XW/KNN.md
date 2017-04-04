><font size = 5>**说明**：
>这篇是KNN算法的第一节，主要介绍了一些基本概念，然后用R语言和python语言对KNN算法进行了相关应用</font>


----------

　　<font size = 4 face = "微软雅黑">K Nearest Neighbor算法又叫KNN算法，这个算法是机器学习里面一个比较经典的算法，总体来说KNN算法是相对比较容易理解的算法。其中的K表示最接近自己的K个数据样本。KNN算法是用来做归类的，也就是说，有一个样本空间里的样本分成很几个类型，然后，给定一个待分类的数据，通过计算接近自己最近的K个样本来判断这个待分类数据属于哪个分类。**你可以简单的理解为由那离自己最近的K个点来投票决定待分类数据归为哪一类。**</font>


----------

#一、 k近邻算法


----------


><font size = 4 face = "微软雅黑">给定一个训练数据集，对新的输入实例，在训练数据集中找到跟它最近的k个实例，根据这k个实例的类判断它自己的类（一般采用多数表决的方法）。</font>

<font size = 4 face = "微软雅黑">一图胜千言：</font>
<div align=center> 
![knn1](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/KnnClassification.svg/220px-KnnClassification.svg.png)

<font size = 4 face = "微软雅黑">测试样本（绿色圆形）应归入要么是第一类的蓝色方形或是第二类的红色三角形。如果k=3（实线圆圈）它被分配给第二类，因为有2个三角形和只有1个正方形在内侧圆圈之内。如果k=5（虚线圆圈）它被分配到第一类（3个正方形与2个三角形在外侧圆圈之内）。</font>


<font size = 4 face = "楷体">**KNN算法**</font>

<font size = 4 face = "楷体">输入：训练数据集</font>
<div align=center>
$$T=\lbrace(x_1,y_1),(x_2,y_2),\ldots,(x_N,y_N)\rbrace$$

<font size = 4 face = "楷体">其中，$x_i$为实例的特征向量，$y_i$为实例的类别，$i=1,2,3,\ldots,N$;实例特征向量$x$.</font>

<font size = 4 face = "楷体">输出：实例$x$所属的类$y$</font>

<font size = 4 face = "楷体">（1）根据给定的**距离度量**，在训练集$T$中找出与$x$最邻近的$k$个点，涵盖这$k$个点的邻域记作$N_k(x)$;
（2）在$N_k(x)$中根据分类规则（一般为多数表决）决定$x$的类别：</font>
<div align=center>
$$y=argmax\sum_{x_i\in N_k(x)}I(y_i = c_j)$$

<font size = 4 face = "楷体">$I$为指示函数，当$y_i=c_j$时$I=1$否则$I = 0$.</font>


# 二、K近邻模型


----------


<font size = 4 face = "微软雅黑">模型有三个要素</font>
<font size = 4 face = "微软雅黑">
 1. 距离度量的选择
 2. K值的选择
 3. 分类决策规则
 </font>

<font size = 4 color = red>**距离度量的选择**</font>
<font size = 4 >
 **1. 闵可夫斯基距离**
 明氏距离又叫做明可夫斯基距离，是欧氏空间中的一种测度，被看做是欧氏距离和曼哈顿距离的一种推广。
 对两点
 $P=(x_1,x_2,\ldots,x_n) $ 和  $Q=(y_1,y_2,\ldots,y_n)$
之间的闵可夫斯基距离：</font>
 <font size = 4 >
 $$L_p(x_i,x_j)=(\sum_{i=1}^{n} {|x_i-y_i|^p})^\frac 1p$$
$p$可以任意指定</font>


 <font size = 4 >**2.欧氏距离和曼哈顿距离 **
 当闵可夫斯基距离的$p$值为2时，是欧氏距离。$p$=1时是曼哈顿距离
 如下图所示，白色表示高楼大厦，灰色表示街道。绿色的斜线表示欧几里得距离。其他三条折线表示了曼哈顿距离，这三条折线的长度是相等的。当 p 趋近于无穷大时，闵可夫斯基距离转化成**切比雪夫距离**</font>
 <div align = center>
![这里写图片描述](http://img.blog.csdn.net/20170105192417864?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTWFya1Nlbkxhbg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast )

 <font size = 4 >**3. 切比雪夫距离**
 当$p$趋近于无穷大时
 $$\lim_{p \to +\infty}  (\sum_{i=1}^{n} {|x_i-y_i|^p})^\frac 1p=\max_{i=1}^{n}|x_i-y_i|$$


![这里写图片描述](http://img.blog.csdn.net/20170105193551291?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvTWFya1Nlbkxhbg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


<font size = 4 color = red>**K值的选择**</font>
<font size = 4 >
由最开始的例子我们可以看到K值的选取对模型的结果的影响是十分显著的。
最简单的K值就是***K=1***。1-近邻法，在1967年Cover和Hart对这个方法进行了研究。用普通贝叶斯方法，预测$X_0$输出变量类别取1的概率为$P(y=1|X)$，预测错误的概率为$1-P(y=1|X)$。</font>
<font size = 4 >
若这个近邻以$P(y=1|X)$的概率取类别1，则预测$X_0$的类别为1时犯错的概率为$1-P(y=1|X)$。
若这个近邻以$P(y=0|X)$的概率取类别0，则预测$X_0$的类别为0时犯错的概率为$1-P(y=0|X)$。</font>
<font size = 4 >
所以1-近邻的预测错误的概率为:
$P(y=1|X)[1-P(y=1|X)]+P(y=0|X)[1-P(y=0|X)]$
$=2P(y=1|X)[1-P(y=1|X)]$</font>
<font size = 4 >
又由于
$2P(y=1|X)[1-P(y=1|X)]\leq2[1-P(y=1|X)]$
所以1-近邻法的预测错误的概率不会高于普通贝叶斯方法预测的2倍。
**1-近邻法的优点：**</font>

- <font size = 4 > 特征空间的纬度低，且类别边界极不规则时比较有效</font>
- <font size = 4 > 十分简单</font>

<font size = 4 >**1-近邻法的缺点：**</font>

 - <font size = 4 >预测波动较大（方差大），稳健性低</font>
 
<font size = 4 >所以可以增大K值来增加模型的稳健性，但是随之而来的是预测误差会变大，因此可以根据预测误差的大小接收程度来设置K值。在回归分析中，我们用均方误差（变量实际值与预测值之差的平方和的平均）即$MSE=\frac1n\sum_{i=1}^n(y_i-\hat{y_i})^2$。然而在新数据中我们拿不到类别的真值，所以只能对预测误差进行估计。</font>
<font size = 4 >
一般估计有２种方法**旁置法**和**留一法**
**旁置法：**旁置法适用于大数据集，通常将数据集的60%~70%作为训练样本（train_dataset），剩下的数据作为测试样本（test_dataset）
**留一法：**假设有$N$个样本，将每一个样本作为测试样本，其它$N-1$个样本作为训练样本。这样得到$N$个分类器，$N$个测试结果。用这$N$个结果的平均值来衡量模型的性能。</font>
<font size = 4 >
**注：**后续会讨论交叉验证</font>


----------


# 三、简单示例


----------

####**R语言实现KNN**

<font size = 4 >
R语言中实现K-近邻法的函数是`class`包中的`knn`函数。</font>
<div align=center><font size = 4>
knn(train=训练样本集, test=测试样本集，cl=输出变量，k=近邻个数K，prob=TRUE/FALSE，use.all=TRUE/FALSE)</font>

<font size = 4 >
我们使用`iris`数据集
```
head（iris）
Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa

```
<font size = 4 >第一步：数据集分为训练集和测试集</font>
```
index <- sample(1:nrow(iris), 100)
iris_train <- iris[index,]
iris_test <- iris[-index,]
```
<font size = 4 >第二步：加载能够做k近邻的class包</font>
```
library(class)
```
<font size = 4 >第三步：利用kNN算法对测试集进行分类</font>
```
result_KNN <- knn(train = subset(iris_train, select = -Species),
                  test = subset(iris_test, select = -Species),
                  cl = iris_train$Species)
```
<font size = 4 >第四步：生成结果集的混淆矩阵</font>
```
table(result_KNN,iris_test$Species)
result_KNN   setosa versicolor virginica
  setosa         14          0         0
  versicolor      0         12         1
  virginica       0          2        21
```

####**scikit-learn的实现**
>#未完待续
```
import numpy
from sklearn import datasets,neighbors,cross_validation
 
iris = datasets.load_iris()
#查看数据的规模
iris.data.shape
#查看训练目标的总类
numpy.unique(iris.target)
#返回一个随机序列
permutation = numpy.random.permutation(iris.target.size)

iris.data = iris.data[permutation]
iris.target = iris.target[permutation]

knnModel = neighbors.KNeighborsClassifier(n_neighbors=3)
#训练模型
knnModel.fit(iris.data[:100], iris.target[:100]) 

#对模型进行评价
knnModel.score(iris.data[100:], iris.target[100:]) 
cross_validation.cross_val_score(
    knnModel, 
    iris.data[100:], 
    iris.target[100:]
)
```
