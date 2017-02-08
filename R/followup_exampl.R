install.packages("GGally")
install.packages("network")
install.packages("sna")
install.packages("ggplot2")
install.packages("intergraph")
install.packages("ndtv")
install.packages("extrafont")

library(GGally)
library(network)
library(sna)
library(ggplot2)
library(RColorBrewer)
library(intergraph)
library(igraph)
library(ndtv)
library(extrafont)

#------------ analyze------------#
nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

head(nodes)
head(links)
nrow(nodes); length(unique(nodes$id))
nrow(links); nrow(unique(links[,c("from","to")]))

links<-aggregate(links[,3], links[,-3], sum)
links<-links[order(links$from, links$to),]
colnames(links)[4]<-"weight"
rownames(links)<-NULL

nodes2 <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)

head(nodes2)
head(links2)

links2<-as.matrix(links2)
dim(links2)
dim(nodes2)


net<-graph.data.frame(links,nodes,directed=T)
net

E(net)
V(net)
E(net)$type
V(net)$media

net[1,]
net[5,7]

plot(net)

net<-simplify(net, remove.multiple = F,remove.loops = T)

pal3 <- brewer.pal(10, "Set3")
plot(net, edge.arrow.size=.4, vertex.label=NA, vertex.color=pal3)
font_import()
