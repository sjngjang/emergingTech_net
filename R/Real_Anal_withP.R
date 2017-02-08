install.packages("DiagrammeR")
library(DiagrammeR)

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


#-------------------

patents <- read.csv("da_node_v1_classMod.csv", header=T, as.is=T)
cites <- read.csv("da_endges_v1.csv", header=T, as.is=T)

head(patents)
head(cites)


grViz("
digraph dot {
      
      graph [layout = dot,
      rankdir = LR]
      
      node [shape = circle,
      style = filled,
      color = grey,
      label = '']
      
      node [fillcolor = red]
      a
      
      node [fillcolor = green]
      b c d
      
      node [fillcolor = orange]
      
      edge [color = grey]
      a -> {b c d}
      b -> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}
      }")

