install.packages("DiagrammeR")
library(DiagrammeR)
library(magrittr)
library(stringr)

#------
# for handling data set
install.packages("dplyr")
install.packages("FSAdata")
install.packages("plotrix")
install.packages("sqldf")
install.packages("readr")

library(dplyr)
library(FSAdata)
library(plotrix)
library(sqldf)
library(readr)
#----

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

pnodes <- read.csv("da_node_v1_classMod.csv", header=T, as.is=T)
cites <- read.csv("da_endges_v1.csv", header=T, as.is=T)
ipc_c<- read.csv("ipc_chan_only.csv", header = T, as.is = T)

head(pnodes)
head(cites)
head(ipc_c)

new_pat <- inner_join(pnodes , ipc_c, by="ipc")
head(new_pat)

#check whether there are duplicated row
nrow(new_pat)
nrow(distinct(new_pat))

#Delect Duplicated row
dist_pat<-distinct(new_pat)
nrow(dist_pat)

#Create a DiagrammeR graph

#Insert the nodes to graph_1
graph_1<-
  create_graph() %>%
  add_nodes_from_table(dist_pat)

#Insert the edges to graph_1
graph_1<-
  graph_1 %>%
  add_edges_from_table(cites,from_col="from", to_col="to",
                       ndf_mapping="pid")

#Check nodes and edges
graph_1 %>% get_edge_df %>% .[, 1:5] %>% head
graph_1 %>% get_node_df %>% .[, 1:10] %>% head

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
  add_global_graph_attrs("style","filled","node")

render_graph(graph_1)


# another graph using nodes, edges
pn<-get_node_df(graph_1)
head(pn)
ce<-get_edge_df(graph_1)

graph_2<-
  create_graph(
    nodes_df=pn,
    edges_df=ce
  )

vivagraph(pn,ce)


graph_1<- graph %>%
select_nodes(conditions ="grep('^H03K',ipc1)")%>%
get_selection(graph_1)
  
help("select_nodes")


