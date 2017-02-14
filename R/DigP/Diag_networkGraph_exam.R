############
#Network Graph Example
############

library(DiagrammeR)
library(magrittr)

graph<-
  create_graph()%>%
  set_graph_name("software_projects")%>%
  set_global_graph_attrs(
    "output","visNetwork","graph")%>%
  add_nodes_from_table(
    system.file(
      "extdata","contributors.csv",
      packate="DiagrammeR"),
    set_type="person",
    label_col="name") %>%
  add_nodes_from_table(
    system.file(
      "extdata","projects.csv",
      package="DiagrammeR"),
    set_type="project",
    label_col="project")%>%
  add_edges_from_table(
    system.file(
      "extdata","projects_and_contributors.csv",
      package="DiagrammeR"),
    from_col="contributor_name",
    to_col="project_name",
    ndf_mapping="label",
    rel_col="contributor_role")
