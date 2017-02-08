#random graph
net= rgraph(10, mode="graph", tprob=0.5)
net= network(net,directed=FALSE)

writeLines(as.character(net[[1]]))

#VERTEX NAMES
network.vertex.names(net)=letters[1:10]

#visualizatoin
ggnet2(net, node.size=6, node.color = "black", edge.size=1, edge.color="grey")
ggnet2(net, size=6, color=rep(c("tomato","steelblue"),5))
help(rep)

#node placement
ggnet2(net, mode="circle")
ggnet2(net, mode = "kamadakawai")

ggnet2(net,mode="fruchtermanreingold", layout.par = list(cell.jitter=0.75))
ggnet2(net, mode = "target", layout.par = list(niter=100))

#node colors
net %v% "phono" = ifelse(letters[1:10] %in% c("a","e","i"), "vowel", "consonant")
ggnet2(net,color="phono")

net %v% "color" = ifelse(net %v% "phono" == "vowel","steelblue","tomato")
ggnet2(net, color="color")

#another node color way
ggnet2(net, color = "phono", color.palette=c( "vowel" = "steelblue", "consonant" = "tomato" ))
ggnet2(net, color = ifelse(net %v%  "phono" =="vowel", "steelblue", "tomato" ))


ggnet2(net, color="phono", palette="Set2")

# node size
ggnet2(net, size="phono")
ggnet2(net,size="phono", size.palette = c("vowel" = 10, "consonant" = 2))

ggnet2(net, size= sample(0:2, 10, replace=TRUE), max_size = 9)

ggnet2(net,size="degree", size.cut = 3)
#a = degree(net, cmode="outdegree")
#ggnet2(net,size=a)

#remove any isolated nodes
x=ggnet2(net, size="degree", size.min=1)

x=ggnet2(net,size="degree", size.max=1)

ggnet2(net, size=sample(0:2, 10, replace=TRUE), size.zero=TRUE)

#node legends
ggnet2(net, alpha="phono", alpha.legend="Phonetics")
ggnet2(net, shape="phono", shape.legend="Phonetics")
ggnet2(net, color="phono", golor.legend="Phonetics")
ggnet2(net,size="degree", size.legend="Centrality")

ggnet2(net, color="phono", size="degree") +
  guides(color=FALSE, size= FALSE)

#control the colors of the nodes
ggnet2(net, color="phono") +
  scale_color_brewer("", palette="Set1",
                     labels = c("consonant" = "C", "vowel"= "V"),
                     guide = guide_legend (override.aes = list(size=6)))

#control the size of the nodes
ggnet2(net, size="degree") +
  scale_size_discrete("", range=c(5,10), breaks = seq(10, 2, -2))

ggnet2(net, color="phono", legend.size=12, legend.position="bottom") +
  theme(panel.background = element_rect(color="grey"))

#node labels
ggnet2(net, label = TRUE)
ggnet2(net, label="phono")
ggnet2(net,label=1:10)

ggnet2(net,label=c("a","e","i"), color="phono",palette="Set2", label.color="black")

ggnet2(net,size=12, label=TRUE, label.size = 5)
ggnet2(net,size=12, label=TRUE, color="black", label.color = "white")

ggnet2(net, label=TRUE, label.alpha=0.75)

#example
ggnet2(net, color="grey15", size=12, label=TRUE, label.color="color")+
  theme(panel.background=element_rect(fill="grey15"))


#node shape and transparency
ggnet2(net,color="phono",shape=20)

ggnet2(net, color="phono", shape="phono")
ggnet2(net, alpha="phono", alpha.palette=c("vowel"=0.2, "consonant" = 1))
ggnet2(net, shape="phono", shape.palette=c("vowel"=19, "consonant" = 15))

#variance of shape
ggnet2(net, shape=sample(1:10))
ggnet2(net, alpha="phono")
