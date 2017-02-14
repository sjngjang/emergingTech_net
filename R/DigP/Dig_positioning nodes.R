library(DiagrammeR)
library(magrittr)

######################
######################
######################

# Create a simple graph with 4 nodes
graph<-
  create_graph()%>%
  add_node(label = "one") %>%
  add_node(label = "two") %>%
  add_node(label = "three") %>%
  add_node(label = "four")


# Add position information to each of
# the graph's nodes
graph<-
  graph%>%
  set_node_position(
    node=1, x=1, y=1) %>%
  set_node_position(
    node = 2, x = 2, y = 2) %>%
  set_node_position(
    node = 3, x = 3, y = 3) %>%
  set_node_position(
    node = 4, x = 4, y = 4)


# View the graph's node data frame to
# verify that the `x` and `y` node
# attributes are available and set to
# the values provided

get_node_df(graph)


# The same function can modify the data
# in the `x` and `y` attributes

graph<-
  graph %>%
  set_node_position(
    node = 1, x = 1, y = 4) %>%
  set_node_position(
    node = 2, x = 3, y = 3) %>%
  set_node_position(
    node = 3, x = 3.5, y = 2) %>%
  set_node_position(
    node = 4, x = 4, y = 1)

get_node_df(graph)

render_graph(graph)
