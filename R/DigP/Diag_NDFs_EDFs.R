#------------------------
#Node and Edge Data Frames
#---------------------------
#These functions are used to create and manipulate specialized data frames:
# node data frames (NDFs) and edge data frames (EDFs).
# The functions are useful because one can selectively add
# field data to these data frames and combine them as necessary
# before addition to a graph object.

#.............
#................
#Create an NDF

###
# Create node data frames
###

library(DiagrammeR)
packageVersion("DiagrammeR")
install.packages("NDF")

# Create a node data frame
node_1 <-
  create_node_df(
    n=4,
    type=c("a", "b", "c", "d"),
    label = TRUE,
    style="filled",
    color="aqua",
    shape=c("circle", "circle", "rectangle","rectangle"),
    data=c(3.5, 2.6, 9.4, 2.7)
  )

#Inspect the 'node_1' NDF
node_1

#Create another node data frame
nodes_2<-
  create_node_df(
    n=4,
    type="a",
    label=c(2384, 3942, 8362, 2194),
    style = "filled",
    color = "aqua",
    shape = c("circle", "circle",
              "rectangle", "rectangle"),
    value = c(3.5, 2.6, 9.4, 2.7)
  )

#inspect the 'nodes_2' NDF
nodes_2



###########################
#Creating an EDF 
###########################

edges_1<-
  create_edge_df(
    from=c(1,2,3),
    to=c(4,3,1),
    rel="a"
  )

#inspect 'edges_1'
edges_1

#create another edges
edges_2<-
  create_edge_df(
    from = c(1, 1, 2, 3),
    to = c(4, 5, 3, 1),
    rel = "a",
    length = c(50, 50, 100, 250),
    color = "green",
    width = c(1, 3, 5, 2))


#inspect 'edges_2'
edges_2


###########################
# Combining NDFs #
##########################

#combine two node data frames

#create an NDF

nod_df_1<-
  create_node_df(
    n=4,
    label=c("D","Z","E","G"),
    type=c("a","a","b","b"),
    value=c(8.4,3.4,2.9,7.0)
  )

#create another NDF
node_df_2<-
  create_node_df(
    n=2,
    type=c("b","c"),
    label=c("U","A"),
    value=c(0.4,3.4)
  )

#combined the node data frames using the 
# 'combine_ndfs()' function

all_nodes<-combine_ndfs(nod_df_1, node_df_2)

# inspect the combined node data frame
all_nodes

###########################
# Combining EDFs #
##########################

#Combine two edge data frames

#Create an edge data frame
edf_1<-
  create_edge_df(
    from=c(1,1,2,3),
    to=c(2,4,4,1),
    rel="requires",
    color="green",
    data=c(2.7, 8.9, 2.6, 0.6)
  )

#Create a second edge data frame
edf_2<-
  create_edge_df(
    from = c(5,7,8,8),
    to= c(7,8,6,5),
    rel="receives",
    arrowhead="dot",
    color="red"
  )

#combine the two edge data frames
all_edges<-
  combine_edfs(edf_1,edf_2)

#view the combined edge data frame
all_edges
