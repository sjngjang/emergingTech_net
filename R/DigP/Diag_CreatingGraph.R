####################
#.....Graph Creation.....
####################
####################
#------------------------
#Creating a Graph Object
#-----------------------
# The 'create_graph()' function creates a graph object. 
# The function also allows for intialization of the graph name, 
# the graph time (as a time with an optional time zone included), 
# and any default attributes for the graph (i.e., graph, node, or edge attributes).

#-----------------------------

#Create an empty graph

#-----------------------------

library(DiagrammeR)

#Create the graph object
graph<-create_graph()

#Get the class of the object
class(graph)

#It's an empty graph, so no NDF
# or EDF

get_node_df(graph)

get_edge_df(graph)

#By default, the graph is 
# considered as directed

is_graph_directed(graph)



#-----------------------------

#It's possible to include an NDF and not an EDF when calling create_graph.
#  but edges can always be defined later 
# (with functions such as add_edge(), add_edge_df(), add_edges_from_table(), etc.,
# and these functions are covered in a subsequent section).

#-----------------------------

###################
#Create a graph with nodes but no edges
###################

#create an NDF
nodes<-
  create_node_df(
    n=4,
    label="",
    type="lower",
    style="filled",
    color="aqua",
    shape=c("Circle","circle",
            "rectangle","rectangle"),
    value=c(3.5,2.6,9.4,2.7)
  )


#examine the NDF
nodes

#Create the graph and include the
#'nodes' NDF

graph<-create_graph(nodes_df = nodes)

#Examine the NDF within the graph object

get_node_df(graph)

#It's the same NDF(outside and inside the graph)
all(nodes==graph$nodes_df)


###################
#Create a graph with both nodes and edges
# defined, and ,add some default attributes
# for nodes and edges
##################

#create a node data frame

nodes_A <-
  create_node_df(
    n=4,
    label="nodeA",
    type="lower",
    style="filled",
    color="aqua",
    shape=c("circle", "circle",
            "rectangle", "rectangle"),
    value=c(3.5,2.6,9.4, 2.7)
  )
nodes_A
edges_A<-
  create_edge_df(
    from=c(1,2,3),
    to=c(4,3,1),
    rel="leading_to"
  )

graph2<-
  create_graph(
  nodes_df = nodes_A,
  edges_df=edges_A
)

graph2<-
  graph2 %>%
  select_nodes_by_id(1:4)%>%
  select_edges()%>%
  set_edge_attrs_ws("color", "blue")%>%
  set_edge_attrs_ws("arrowsize","2")%>%
  clear_selection()

#examine the NDF within the
#graph object
get_node_df(graph2)

get_edge_df(graph2)



###################

#Viewing a Graph object
#---------------------------------
#With the render_graph() function, it's possible to view the graph object
# in the RStudio Viewer, or, output the DOT code for 
# the current state of the graph.
#---------------------------------
##################

###
#create a simple graph
###

#create a simple NDF
n_1<-
  create_node_df(
    n=4,
    type="number"
  )

#create a simple EDF
e_1<-
  create_edge_df(
    from=c(1,1,3,1),
    to=c(2,3,4,4),
    rel="related"
  )

#create the graph object,
# incorporating the NDF and
# the EDF, and, providing
# some global attributes
graph3<-
  create_graph(
    nodes_df = n_1,
    edges_df = e_1
  )

graph3<-
  graph3%>%
  select_edges()%>%
  #trav_out()%>%
  set_global_graph_attrs("graph","layout","neato")%>%
  set_global_graph_attrs("node","color","blue")%>%
  set_global_graph_attrs("node","fontname","Helvetica")%>%
  select_nodes_by_id(1:4)%>%
  set_node_attrs_ws("shape","box")%>%
  select_edges()%>%
  set_edge_attrs_ws("color","gray20")%>%
  clear_selection()
#Not working
#set_node_attrs_ws("fontname","Helvetica")%>%
#set_node_attrs_ws("color", "blue") %>%
# Using 'Set functions' after call 'select'

#view the graph
render_graph(graph3)


#######################
# Use magrittr's %>% to create a graph and
# then view it without storing that graph object
######################

library(magrittr)


#create a simple NDF
n_2<-
  create_node_df(
    n=4,
    type="integer"
  )

#create a simple EDF
e_2<-
  create_edge_df(
    from=c(1,1,3,1),
    to=c(2,3,4,4),
    rel="related"
  )

# create the graph object,
# incorporating the NDF and
# the EDF, and , providing some
# global attributes

graph4<-
  create_graph(
    nodes_df = n_2,
    edges_df=e_2
  )%>%
  set_global_graph_attrs("graph","layout","neato")%>%
  select_nodes_by_id(1:4)%>%
  set_global_graph_attrs("node","fontname","Helvetica")%>%
  select_edges()%>%
  set_edge_attrs_ws("color","gray20")

render_graph(graph4)

############
#Create and auto rendering
create_graph(
  nodes_df = n_2,
  edges_df=e_2)%>%
  set_global_graph_attrs("graph","layout","neato")%>%
  select_nodes_by_id(1:4)%>%
  set_global_graph_attrs("node","fontname","Helvetica")%>%
  select_edges()%>%
  set_edge_attrs_ws("color","gray20")%>%
  render_graph

############
#Create and auto rendering
#and output the using the output="DOT" option

create_graph(
  nodes_df = n_2,
  edges_df=e_2)%>%
  set_global_graph_attrs("graph","layout","neato")%>%
  select_nodes_by_id(1:4)%>%
  set_global_graph_attrs("node","fontname","Helvetica")%>%
  select_edges()%>%
  set_edge_attrs_ws("color","gray20")%>%
  render_graph(graph, output="vivagraph")
