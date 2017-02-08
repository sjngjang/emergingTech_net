#weighted adjacency matrix
bip=data.frame(event1=c(1,2,1,0),
               event2 =c(0,0,3,0),
               event3=c(1,1,0,4),
               row.names = letters[1:4])

#weighted bipartite network
bip=network(bip,
            matrix.type="bipartite",
            ignore.eval=FALSE,
            names.eval="weights")


writeLines(as.character(bip[[1]]))
ggnet2(bip, label=TRUE)

#set color for each mode
col=c("actor"="grey", "event"="gold")
#detect and color the mode
ggnet2(bip, color="mode", palette=col, label=TRUE)

#edge labels
ggnet2(bip, color="mode", palette=col, label=TRUE, edge.label="weights")

ggnet2(bip, shape="mode", edge.label="weights", edge.label.color="darkred")
ggnet2(bip, shape="mode", edge.label="weights", edge.label.size=6)

set.edge.attribute(bip, "cc", ifelse(bip %e% "weights">1, "black", "grey75"))
ggnet2(bip, color="mode", palette=col, edge.label="weights", edge.label.color="cc")

ggnet2(bip, shape="mode", edge.label="weights", edge.label.fill=NA)

#edge size and color
ggnet2(bip, color="mode", palette=col, edge.size="weights")
set.edge.attribute(bip, "edgeC", ifelse(bip %e% "weights">1 , "black", "grey75"))
ggnet2(bip, color ="mode", palette=col, edge.size="weights", edge.color="edgeC")

#edge line type
set.edge.attribute(bip, "lty2", ifelse(bip %e% "weights">1, 1, 2))
ggnet2(bip, color="mode", palette=col, edge.size = "weights", edge.lty="lty2")

#additional option
ggnet2(network(rgraph(10, tprob=0.25), directed =TRUE), arrow.size=12)
ggnet2(network(rgraph(10, tprob=0.25), directed =TRUE),
       arrow.size=5, arrow.gap=0.025)

#coloring edges from node attribute
ggnet2(net, color="phono", palette="Set1", edge.color=c("color", "grey50"))


#fixed placement coordinates
x=gplot.layout.fruchtermanreingold(net, NULL)
net %v% "x" = x[,1]
net %v% "y" = x[,2]

net %v% "t1" = c(0, 0, 0, 0, 0, 0, 1, 1, 1, 1)
net %v% "t2" = c(0, 0, 0, 0, 1, 1, 1, 1, 1, 1)
net %v% "t3" = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1)

net %v% "t1" = ifelse(net %v% "t1", 1, NA)
net %v% "t2" = ifelse(net %v% "t2", 1, NA)
net %v% "t3" = ifelse(net %v% "t3", 1, NA)

#remove go!!
t1=ggnet2(net, mode=c("x","y"), size=3, color="black", na.rm="t1")
t2=ggnet2(net, mode=c("x","y"), size=3, color="black", na.rm="t2")
t3=ggnet2(net, mode=c("x","y"), size=3, color="black", na.rm="t3")

#common plotting parameters
b=theme(panel.background=element_rect(color="grey50"))
z=guides(color=FALSE)
y = scale_y_continuous(limits = range(x[,2] * 1.1),  breaks =NULL)
x = scale_x_continuous(limits=range(x[,1] *1.1), breaks =NULL)

#SHOW Each temporal network
gridExtra::grid.arrange(t1 + x + y + z + ggtitle("t=1") + b,
                        t2+x+y+z+ggtitle("t=2")+b,
                        t3+x+y+z+ggtitle("t=3")+b,
                        nrow=1)

#expanding the horizontal axis

#no hotizontal expansion
ggnet2(net, lable=rep("abcdefghijklmnopqrstuvwxyz",10))

#50% horizontal expansion
ggnet2(net, label=rep("abcdefghijklmnopqrstuvwxyz", 10), layout.exp=0.5)


#hacking in to internal values
ggnet2(net, color = "phono", size=1:10)$data

ggnet2(net, color = "phono", palette ="Set1", size =0) +
  geom_point(aes(color=color), size=12, color="white")+
  geom_point(aes(color=color), size=12, alpha = 0.5) +
  geom_point(aes(color=color), size=9) +
  geom_text(aes(label = toupper(substr(color, 1, 1))), color="white", fontface="bold")+
  guides(Color=FALSE)
