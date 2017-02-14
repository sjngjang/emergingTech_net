library(DiagrammeR)
library(magrittr)
# Create a graph with a cycle with 6 nodes
graph_cycle <-
  create_graph() %>%
  add_cycle(n = 6)

# Create a random graph with 8 nodes, 15 edges
graph_random <-
  create_random_graph(
    8, 15, set_seed = 1)

# Combine the two graphs in a union operation
combined_graph <-
  combine_graphs(graph_cycle, graph_random)


render_graph(combined_graph)
# Get the number of nodes in the combined graph
node_count(combined_graph)
#> [1] 14



########################
########################

# Create three graphs
graph_1 <-
  create_graph() %>%
  add_n_nodes(3) %>%
  add_edges_w_string(
    "1->3 1->2 2->3")
graph_2 <-
  graph_1 %>%
  add_node() %>%
  add_edge(4, 3)
graph_3 <-
  graph_2 %>%
  add_node() %>%
  add_edge(5, 2)
# Create an empty graph series and add
# the graphs
series <-
  create_series() %>%
  add_to_series(graph_1, .) %>%
  add_to_series(graph_2, .) %>%
  add_to_series(graph_3, .)

render_graph(series)
render_graph_from_series(series,3)
