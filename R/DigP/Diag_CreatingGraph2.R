######################

# Create a 'Random' Graph

######################

#--------------------
#Creating a random graph is actually quite useful.
#Seeing these graphs with specified numbers of nodes and edges will allow 
# you to quickly get a sense of how connected graphs can be at different sizes.


####
# Create a very simple random graph
###
library(DiagrammeR)
library(magrittr)

#create a simple, random graph
# and render with the 'visNetwork'
# output option
render_graph(
  create_random_graph(n=2, m=1),
  output="visNetwork"
)

#---------------------------------------
####
# Create a random graph with 15 nodes, 30 edges
###
library(DiagrammeR)

#create random graph with
# 15 nodes and twice as many edges
# and then render the graph with
# the 'visNetwork' output option

render_graph(
  create_random_graph(n=15, m=30),
  output="visNetwork"
)



#---------------------------------------
####
# Create a random, fully-connected graph of 15 nodes
###
library(DiagrammeR)

# Attempt to generate a random 
# graph with 15 nodes and 200 edges
# (more than the number of edges in
# a fully-connected graph with
# single edges between nodes)

render_graph(
  create_random_graph(n=15, m=200),
  output="visNetwork"
)
# It shows an Error
# the solotion!!
# Use 'n=15' and 'm=105' to
# yeild a fully-connected graph
# with 15 nodes

render_graph(
  create_random_graph(n=15, m= 105),
  output="visNetwork"
)



#---------------------------------------
####
# Create a random with
# many nodes but with no edges
###

# Create a random graph with
# 512 nodes but no edges

render_graph(
  create_random_graph(n=512, m=0),
  output="visNetwork"
)



#---------------------------------------
####
# Create a reproducible, random graph
####

# Create a random graph with
# a seed set so that the same graph
# will be generated every time

render_graph(
  create_random_graph(n=5, m=4,
                      set_seed = 30),
  output="visNetwork"
)



#---------------------------------------
####
# Create a random, directed graph
####

# Create a random graph but with
# directed edges by setting
# 'directed=TRUE'

render_graph(
  create_random_graph(
    n=15, m=22, directed = TRUE),
  output="visNetwork"
)



#---------------------------------------
####
# Create two graphs and combine them into one
####

# Create the first graph

nodes_1<-create_node_df(n=10, id=1:10, label=1:10)

edges_1<-create_edge_df(from=1:9, to=2:10, use_labels=TRUE)

graph_1<-create_graph(
  nodes_df = nodes_1,
  edges_df = edges_1
)%>%
  set_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("rankdir","LR","graph")
get_global_graph_attrs(graph_1)
render_graph(graph_1)
#create the second graph (note that node ID values
#are different from those of the first graph)

nodes_2<-
  create_node_df(n=10, id=11:20, label=11:20)

edges_2<-
  create_edge_df(from=11:19, to=12:20, use_labels=TRUE)

graph_2<-
  create_graph(
    nodes_df = nodes_2,
    edges_df = edges_2
  )%>%
  set_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("rankdir","TD","graph")

render_graph(graph_2)

#Combine the two graphs, the
# global graph attribute
#'set_global_graph_attrs ("graph","rankdir","LR")
#'will be retained since it is
#'part of the graph supplied as 'x'

get_node_df(graph_1)
get_edge_df(graph_1)
get_node_df(graph_2)
get_edge_df(graph_2)

combined_graph<-
  combine_graphs(x=graph_1, y=graph_2)

combined_graph2<-
  combine_graphs(x=graph_2, y=graph_1)

#'Display the combined graph
get_global_graph_attrs(combined_graph)
get_global_graph_attrs(combined_graph2)

render_graph(combined_graph)
render_graph(combined_graph2)



######
#Create two graphs and combine them
######

library(DiagrammeR)

#Create_ the first grpah

n_1<-create_node_df(n=10, id=1:10)
e_1<-create_edge_df(from=1:9, to=2:10)

g_1<-
  create_graph(
    nodes_df = n_1,
    edges_df = e_1) %>%
  set_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("rankdir","LR","graph")

#create the second graph
n_2<-
  create_node_df(n=10, id=11:20)

e_2<-
  create_edge_df(from=11:19, to=12:20)

g_2<-
  create_graph(
    nodes_df = n_2,
    edges_df = e_2
  )

#create an auxiliary EDF for
#creating edges across the two
#graphs supplied as 'x' and 'y'
#to 'combine_graphs()'
extra_edges<-
  create_edge_df(
    from=c(5,19,1),
    to=c(12,3,11)
  )

#combine thw two graphs, adding
# the 'extra_edges'EDF to the
#'edges_df' argument

combined_graph<-
  combine_graphs(
    x=g_1,
    y=g_2
  )%>%
  add_edge_df(extra_edges)

# Display the combined graph
render_graph(combined_graph)
