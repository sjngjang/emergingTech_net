install.packages("ndtv")
install.packages("htmlwidgets")
install.packages("scatterplot3d")
library(ndtv)
library(htmlwidgets)
library(scatterplot3d)

install.packages("tsna")

library(tsna)



#-------------- packages ---------------#


writeLines(as.character(short.stergm.sim[[2]]))

data(short.stergm.sim)
render.animation(short.stergm.sim)
ani.replay()
render.d3movie(short.stergm.sim)
render.d3movie(short.stergm.sim, output.mode = 'htmlWidget')
filmstrip(short.stergm.sim, displaylabels=FALSE)

#timePrism projection
compute.animation(short.stergm.sim)
timePrism(short.stergm.sim, at=c(1,10,20),
          displaylabels=TRUE, planes= TRUE,
          label.cex=0.5)


#plot a timeline
timeline(short.stergm.sim)

#plot a proximity timeline
proximity.timeline(short.stergm.sim, default.dist=6, mode='sammon', labels.at = 17, vertex.cex=4)


#load the data
head(as.data.frame(short.stergm.sim))

data(short.stergm.sim)
spls<-as.data.frame(short.stergm.sim)
spls[spls$duration==25,]

#compute some basic tempporal stats
tEdgeFormation(short.stergm.sim)

plot(tEdgeFormation(short.stergm.sim))


#static graph-level sna measure as a time series
plot(tSnaStats(short.stergm.sim, 'gtrans'))

#temporally reachable paths
path<-tPath(short.stergm.sim, v=5,
           graph.step.time = 1 )

plotPaths(short.stergm.sim,
          path,
          label.cex=0.5)
