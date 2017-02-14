?library(igraph)
library(DiagrammeR)

tf <- tempfile()

write.graph(
  graph.famous("Tetrahedron")
  ,tf
  ,format="dot"
)

grViz(
  readLines(tf)
)

library(htmltools)
html_print(tagList(
  lapply(
    c("neato","circo","twopi")
    ,function(engine){ grViz( readLines(tf) , engine = engine ) }
  )  
))


unlink(tf)


#####################
#####################
#####################
##################### 


#' Create a DiagrammeR graph object

graph<-
  create_random_graph(
    36,50, set_seed = 1)
help("set.seed")
#' set.seed is random number generation function

#'Confirm that 'graph' is a DiagrammeR graph
#'by getting the object's class

class(graph)


#convert the DiagrameR graph to an igraph object
ig_graph <- to_igraph(graph)

#Get the class of the converted grpah, just
#to be certain
class(ig_graph)

#get a summary of the igraph graph object
summary(ig_graph)




#######################################
install.packages("igraph")
install.packages("pipeR")

library(DiagrammeR)
library(igraph)
library(pipeR)

###use igraph example from documentation

actors <- data.frame(
  name=c("Alice", "Bob", "Cecil", "David", "Esmeralda")
  , age=c(48,33,45,34,21)
  , gender=c("F","M","F","M","F")
)

relations<-data.frame(
  from=c("Bob", "Cecil", "Cecil", "David", "David", "Esmeralda")
  , to=c("Alice", "Bob", "Alice", "Alice", "Bob", "Alice")
  , same.dept=c(FALSE,FALSE,TRUE,FALSE,FALSE,TRUE)
  , friendship=c(4,5,5,2,1,1), advice=c(4,5,5,4,2,3)
)

g<-graph_from_data_frame(relations, directed = TRUE, vertices = actors)


##use igraph layout for positions
g_layout <-layout.grid(g)
print(g, e=TRUE, v=TRUE)


###now plot with DiagrammeR using igraph layout positions
###but use graphviz splines and overlap handling
g%>>%
  get.data.frame(what="both")%>%
  (
    #DiagrammeR create_graph helper function
    create_graph(
      data.frame(
        nodes=rownames(.$vertices)
        ,.$vertices
        ,x=g_layout[,1] # define our x from the igraph layout
        ,y=g_layout[,2] #define our y from the igraph layout
      )
      ,.$edges
      ,graph_attrs = 'splines="true", overlap = "scale", label = "igraph + grViz"'
    )
  ) %>>%
  (grViz(.$dot_code,engine="neato"))
