install.packages("DiagrammeR")
library(DiagrammeR)
library(magrittr)
library(stringr)

install.packages("GGally")
install.packages("network")
install.packages("sna")
install.packages("ggplot2")
install.packages("intergraph")
install.packages("ndtv")
install.packages("visNetwork")

library(GGally)
library(network)
library(sna)
library(ggplot2)
library(RColorBrewer)
library(intergraph)
library(igraph)
library(ndtv)
library(visNetwork)


#-------------------

patents <- read.csv("da_node_v1_classMod.csv", header=T, as.is=T)
cites <- read.csv("da_endges_v1.csv", header=T, as.is=T)
ipc_c<- read.csv("ipc_chan_only.csv", header = T, as.is = T)

head(patents)
head(cites)
head(ipc_c)



graph_1<-
  create_graph() %>%
  add_nodes_from_table(patents)
graph_1

graph_1<-
  graph_1 %>%
  add_edges_from_table(cites,from_col="from", to_col="to",
                       ndf_mapping="pid")

graph_1 %>% get_edge_df %>% .[, 1:5] %>% head
graph_1 %>% get_node_df %>% .[, 1:5] %>% head

get_global_graph_attrs(graph_1)


graph_1<-
  graph_1 %>%
  set_graph_name("patent_net")%>%
  set_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("rankdir","TD","graph")%>%
  add_global_graph_attrs("shape","circle","node")%>%
  add_global_graph_attrs("fixedsize","FALSE","node")%>%
  add_global_graph_attrs("fontname","Helvetica","node")%>%
  add_global_graph_attrs("fontcolor","gray50","node")%>%
  add_global_graph_attrs("fontsize","12","node")%>%
  add_global_graph_attrs("width","0.2","node")%>%
  add_global_graph_attrs("color","gainsboro","node")%>%
  add_global_graph_attrs("style","filled","node")%>%
  select_nodes(conditions="ipc1=='A61B 19'")%>%
  set_node_attrs_ws("fillcolor","orange")

render_graph(graph_1)

graph_1<- graph %>%
select_nodes(conditions ="grep('^H03K',ipc1)")%>%
get_selection(graph_1)
  
help("select_nodes")


