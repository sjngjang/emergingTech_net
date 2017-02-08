Sys.setlocale("LC_ALL")
Sys.setlocale("LC_ALL", "English_United States.1252")
Sys.setenv(LANG = "en_US.UTF-8")
Sys.getlocale()

#root URL
r<-"https://raw.githubusercontent.com/briatte/ggnet/master/"
#read nodes
v=read.csv(paste0(r, "inst/extdata/nodes.tsv"), sep="\t")
names(v)

#read edges
e=read.csv(paste0(r, "inst/extdata/network.tsv"), sep="\t")
names(e)

#network object
net=network(e, directed=TRUE)

#party affiliation
x=data.frame(Twitter=network.vertex.names(net))
x=merge(x,v,by="Twitter", sort = FALSE)$Groupe
net %v% "party" = as.character(x)

# color palette
y=RColorBrewer::brewer.pal(9, "Set1")[c(3,1,9,6,8,5,2)]
names(y) = levels(x)
y
x

#network plot
ggnet2(net, color="party", palette=y, alpha =0.75, size=4, edge.alpha=0.5)


