install.packages("GGally")
install.packages("network")
install.packages("sna")
install.packages("ggplot2")
install.packages("intergraph")
install.packages("ndtv")
install.packages("visNetwork")

library(GGally)
library(network)
library(sna)
library(ggplot2)
library(RColorBrewer)
library(intergraph)
library(igraph)
library(ndtv)
library(visNetwork)
library(DiagrammeR)

Sys.setlocale("LC_ALL")

#-----------#

patents <- read.csv("da_node_v1_noclassification.csv", header=T, as.is=T)
cites <- read.csv("da_endges_v1.csv", header=T, as.is=T)

head(patents)
head(cites)

nrow(patents); length(unique(patents$pid))
nrow(cites); nrow(unique(cites[,c("from","to")]))

#cites<-aggregate(cites[,3], cites[,-3], sum)
#cites<-cites[order(cites$FROM, cites$TO),]

colnames(cites)[4]<-"weight"
rownames(cites)<-NULL

setdiff(cites$FROM,patents$pid)


nodes<-data.frame(id=patents$pid )
edges <- data.frame(from=cites$from, to=cites$to )
head(edges)

netp<-graph.data.frame(cites,patents,directed=T)
netp

E(netp)
V(netp)
E(netp)$YEAR


netp[1,]
netp[5,7]

plot(netp)
netp<-simplify(netp, remove.multiple = F,remove.loops = T)


l<-layout.fruchterman.reingold(netp)
l<-layout.norm(l, ymin=-3, ymax=3, xmin=-3, xmax=3)

treeCoords<-network.layout.animate.Graphviz(netp,
                                            layout.par=list(gv.engine='dot',
                                                            gv.args='-Granksep=4'))


plot(netp, edge.arrow.size=.2, edge.color="orange",
     vertex.label=V(netp)$pid, vertex.size=1, vertex.color="orange",
     vertex.frame.color="#ffffff",
     vertex.label.cex=0.1, vertex.label.color="black",
     layout=l*1.0)




plot(x=1:10, y=1:10, pch=19, cex=4, col=pal3)

ggnet2(bip, color="mode", palette=col, edge.label="weights", edge.label.color="cc")

concount<-nrow(cites)
concount
tnetp<-network.initialize(concount)
class(tnetp)
add.edges.active()
tnetp<-networkDynamic(edge.spells=netp)
timeline(netp,plot.edge.spells = FALSE)
