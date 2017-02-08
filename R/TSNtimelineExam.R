install.packages('ndtv', repos='http://cran.us.r-project.org',
                 dependencies=TRUE)
library(ndtv)

install.packages('tsna',repos='http://cran.us.r-project.org',
                 dependencies=TRUE)
library(tsna)

install.packages("networkDynamic")
library(networkDynamic)

library(ndtv)
library(htmlwidgets)
library(scatterplot3d)

#----------------------
data(short.stergm.sim)
timeline(short.stergm.sim,slice.par=list(start=0,end=25,interval=1,
                                         aggregate.dur=1,rule='latest'),
         plot.vertex.spells=FALSE)

#check node in time 0
network.edgecount(network.extract(short.stergm.sim, onset=0, terminus=1))

network.edgecount.active(short.stergm.sim, onset=0, terminus=1)

tErgmStats(short.stergm.sim,'edges', start=0, end=25, time.interval = 1)

timeline(short.stergm.sim, slice.par = list(start=0, end=25, interval=1,
                                            aggregate.dur=0, rule='latest'),
         plot.vertex.spells = FALSE)

tErgmStats(short.stergm.sim, 'edges', start=0, end=25, time.interval = 2, aggregate.dur = 2)

#McFarland(2001)

data(McFarland_cls33_10_16_96)
plot(cls33_10_16_96)

slice.par<-list(start=0, end=30, interval=2.5,
                aggregate.dur=0, rule="latest")
compute.animation(cls33_10_16_96,
                  slice.par = slice.par, animation.mode = 'MDSJ', verbos=FALSE)

render.d3movie(cls33_10_16_96, output.mode = 'htmlWidget')

timeline(cls33_10_16_96, slice.par = slice.par)

plot(tErgmStats(cls33_10_16_96, 'meandeg'),
     main='mean degree of cls33, 1 minute aggregatoin')

slice.par<-list(start=0,end=30,interval=2.5,
                aggregate.dur=2.5,rule="latest")
compute.animation(cls33_10_16_96,
                  slice.par=slice.par,animation.mode='MDSJ',verbose=FALSE)
render.d3movie(cls33_10_16_96,
               displaylabels=FALSE,output.mode='htmlWidget')


timeline(cls33_10_16_96,slice.par=slice.par)
plot(tErgmStats(cls33_10_16_96,'meandeg',
                time.interval = 2.5,aggregate.dur=2.5),
     main='Mean degree of cls33, 2.5 minute aggregation')


slice.par<-list(start=0, end=40, interval=1,
                aggregate.dur=5, rule="latest")
timeline(cls33_10_16_96, slice.par=slice.par)


compute.animation(cls33_10_16_96,
                  slice.par=slice.par,animation.mode='MDSJ',verbose=FALSE)
render.d3movie(cls33_10_16_96,
               displaylabels=FALSE,
               output.mode = 'htmlWidget')

plot(tErgmStats(cls33_10_16_96,'meandeg',
                time.interval = 1,aggregate.dur=5,rule='latest'),
     main='Mean degree of cls33, overlapping 5 minute aggregation')


