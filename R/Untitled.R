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

head(patents)
head(cites)

nrow(patents); length(unique(patents$pid))
nrow(cites); nrow(unique(cites[,c("from","to")]))
