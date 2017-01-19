getwd()

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

#-------------
patents<-read.csv("da_node_v1_noclassification.csv", header=T, as.is=T)
cites<-read.csv("da_endges_v1.csv", header=T, as.is=T)
ipc<-read.csv("ipc_chan_only.csv",header = T, as.is = T)

head(patents)
head(cites)

nrow(patents); length(unique(patents$pid))
nrow(cites); nrow(unique(cites[,c("from","to")]))
pNum<-length(unique(patents$YEAR))
pYear<-c(unique(patents$YEAR))
xRange<-c(1:pNum)
f1<- function(x){
  i<-1
  for(i in 1:x) {
    if(i<x) {
      paste(pYear[i],",")
    }
  }
}
exa<-c(f1(pNum))
ipcNum<-length(unique(ipc$ipc))
g_range<-range(1,ipcNum)


#plotting the graph
plot(patents$YEAR, type="o", col="blue", ylim=g_range, axes=F,ann=F)

axis(1, at=xRange, lab=pYear[
       for(i in 1:pNum){
         if(i<pNum)
           i
       }]
    )
axis(2, las=1, at=10*0:pNum)
