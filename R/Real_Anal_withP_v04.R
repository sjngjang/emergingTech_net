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
#### Call data
pnodes <- read.csv("da_node_v1_position.csv", header=T, as.is=T)
cites <- read.csv("da_endges_v1.csv", header=T, as.is=T)
ipc_c<- read.csv("ipc_chan_only.csv", header = T, as.is = T)

#inspect the called data
head(pnodes)
head(cites)
head(ipc_c)

#inner_join the 'pnodes' and 'ipc_c' tables
new_pat <- inner_join(pnodes , ipc_c, by="ipc")
head(new_pat)

#check whether there are duplicated row
nrow(new_pat)
nrow(distinct(new_pat))

#Delect Duplicated row
dist_pat<-distinct(new_pat)
nrow(dist_pat)
dist_pat<-
  dist_pat %>%
  rowwise()%>%
  mutate(type="patent")


head(dist_pat)
#Create a DiagrammeR graph
#Insert the nodes to graph_1
graph_1<-
  create_graph() %>%
  add_nodes_from_table(dist_pat)%>%
  add_global_graph_attrs("type","patent","node")

#Insert the edges to graph_1
graph_1<-
  graph_1 %>%
  add_edges_from_table(cites,from_col="from", to_col="to",
                       ndf_mapping="pid")

#Check nodes and edges
graph_1 %>% get_edge_df %>% .[, 1:5] %>% head
graph_1 %>% get_node_df %>% .[, 1:13] %>% head

get_global_graph_attrs(graph_1)

# Add graph attributes 
graph_1<-
  graph_1 %>%
  set_graph_name("patent_net")%>%
  #set_global_graph_attrs("output","visNetwork","graph")%>%
  #set_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("rankdir","TD","graph")%>%
  add_global_graph_attrs("shape","circle","node")%>%
  add_global_graph_attrs("fixedsize","YES","node")%>%
  add_global_graph_attrs("fontname","Helvetica","node")%>%
  add_global_graph_attrs("fontcolor","gray50","node")%>%
  add_global_graph_attrs("fontsize","10","node")%>%
  add_global_graph_attrs("width","1","node")%>%
  add_global_graph_attrs("color","gainsboro","node")%>%
  add_global_graph_attrs("style","filled","node")%>%
  add_global_graph_attrs("label","YES","node")
get_global_graph_attrs(graph_1)
render_graph(graph_1)

#######
#make y axis
#select the years and make new nodes
year_info<-select(dist_pat, YEAR,y)
year_info<-mutate(year_info, label = factor(YEAR))
year_info<-mutate(year_info, x = as.numeric(0))
year_info<-
  year_info %>%
  rowwise%>%
  mutate(type="year")
head(year_info)

graph_year<-
  create_graph()%>%
  add_nodes_from_table(year_info)%>%
  add_global_graph_attrs("type","year","node")

graph_year<-
  graph_year%>%
  set_graph_name("year_bar")%>%
  add_global_graph_attrs("rankdir","TD","graph")%>%
  add_global_graph_attrs("shape","plaintext","node")%>%
  add_global_graph_attrs("fixedsize","no","node")%>%
  add_global_graph_attrs("fontname","Helvetica","node")%>%
  add_global_graph_attrs("fontcolor","black","node")%>%
  add_global_graph_attrs("fontsize","8","node")
get_global_graph_attrs(graph_year)
render_graph(graph_year)

#######
#making upper x axis
#select the years and make new nodes

ipc_info<-distinct(select(dist_pat, ipc))
nrow(ipc_info)
ipc_info<-muate(year_info, label=factor(ipc))
ipc_info<-mutate(year_info, y= as.muneric(max(x)+5))


#combine three graphs into 1
combined_graph<-
  combine_graphs(graph_1,graph_year)

get_global_graph_attrs(combined_graph)
head(combined_graph)

render_graph(combined_graph)


###change diagrammeR network to igraph network
ipat_graph<-to_igraph(combined_graph)

###igraph rendering
#va<-vertex_attr(ipat_graph, "type")

head(ipat_graph)
plot(ipat_graph, edge.arrow.size=.4, vertex.size=2, vertex.label.font=1, vertex.label.cex=.5,
     vertex.label.color="gray40")


#change igraph to visNetwork rendering

vis_pat_graph<-toVisNetworkData(ipat_graph, idToLabel = FALSE)

pat_nodes<-vis_pat_graph$nodes
pat_edges<-vis_pat_graph$edges

#assign node attribute
pat_nodes$group<-pat_nodes$type

visNetwork(pat_nodes, pat_edges,main="Network!") %>%
  visIgraphLayout() %>%
  visGroups(groupname="patent", font.size=6, color="tomato", size=5)%>%
  visGroups(groupname="year", shape="text")





