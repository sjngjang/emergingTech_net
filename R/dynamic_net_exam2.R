install.packages('ndtv', repos='http://cran.us.r-project.org',
                 dependencies=TRUE)
library(ndtv)

install.packages('tsna',repos='http://cran.us.r-project.org',
                 dependencies=TRUE)
library(tsna)

install.packages("networkDynamic")
library(networkDynamic)
#------------- network practice -----------#

#static network with 10 vertices

wheel<-network.initialize(10)
class(wheel)

add.edges.active(wheel, tail=1:9, head=c(2:9,1), onset=1:9, terminus=11)
add.edges.active(wheel,tail=10, head=c(1:9), onset=10, terminus=12)

#add active edge
class(wheel)

print(wheel)

as.data.frame(wheel)
plot(wheel)
plot(network.extract(wheel, at=1))
plot(network.extract(wheel, onset=1, terminus=5))

get.edge.activity(wheel)[1:2]

#labeling
elabels<-lapply(get.edge.activity(wheel),
                function(spl){
                  paste("(",spl[,1],"-",spl[,2],")",sep='')
                })

#plot
plot(wheel, displaylabels=TRUE, edge.label=elabels,
     edge.label.col='steelblue')

render.animation(wheel)
ani.replay()

#example 2

#create a network object from each matrix
t0<-as.network(matrix(c(0,1,0,
                        0,0,0,
                        1,0,0), ncol=3, byrow=TRUE))

t1<-as.network(matrix(c(0,1,0,
                        0,1,0,
                        0,0,0), ncol=3, byrow=TRUE))

t2<-as.network(matrix(c(0,0,0,
                        0,1,0,
                        0,1,0), ncol=3, byrow=TRUE))

#convert a list of networks into networkDynamic object
tnet<- networkDynamic(network.list = list(t0,t1,t2))

as.data.frame(tnet)[,1:4]

#create a networkDynamic object
tetl<-matrix(c(0,1,3,1,
               0,2,1,2,
               2,3,3,2), ncol=4, byrow=TRUE)
tnet<-networkDynamic(edge.spells = tetl)

#controlling animation processing steps
slice.par=list(start=1, end=12, interval=1, aggregate.dur=1, rule='latest')

compute.animation(wheel,animation.mode='kamadakawai',slice.par=slice.par)

#the x and y coordinates for plotting each time point are now stored in the network.
list.vertex.attributes(wheel)

#peek at x cords at time 4
get.vertex.attribute.active(wheel, 'animation.x', at=4)

#collapse the dynamic and plot
wheelAt8<-network.collapse(wheel,at=8)
coordsAt8<-cbind(wheelAt8 %v% 'animation.x', wheelAt8 %v% 'animation.y')
plot(wheelAt8, coord=coordsAt8)


#rendering aes setting
render.animation(wheel,vertex.col='steelblue', edge.col='gray', main='A network animation')

#set rendering time
render.animation(wheel, render.par=list(tween.frames=1),
                 vertex.col='steelblue', edge.col='gray60')
ani.replay()

render.animation(wheel, render.par=list(tween.frames=30),
                 vertex.col='steelblue', edge.col='gray60')
ani.replay()





