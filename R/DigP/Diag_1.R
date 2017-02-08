library(DiagrammeR)

#Defining a Graphviz Graph

grViz("
digraph boxes_andcircles {
      
  # a 'graph' statement
  graph [overlap = true, fontsize=10]

  # several 'node' statements
  node [shape =box,
        fontname=Helvetica]
  A; B; C; D; E; F

  node [shape = circle,
        fixedsize=true,
        sidth=0.9] //sets as circles
  1; 2; 3; 4; 5; 6; 7; 8

  #several'edge' statements
  A->1 B->2 B->3 B->4 C->A
  1->D E->A 2->4 1->5 1->F
  E->6 4->6 5->7 6->7 3->8
}")

#-------------------------
#Subgraphs and Clusters
# ex) if B,c should show in same place
# then, A->{B C}   or   A-> B
#                       A-> C




#------------------------
#Graphiz Substitution
#The notation @@ within GraphViz DOT will indicate
#where the substitution is to take place and 
#corresponding R expressions will provide values to be substituted.

grViz("
      
  digraph a_nice_graph{

  #node definition with substituted label text
  node[fontname = Helvetica]
  a[label='@@1']
  b[label='@@2-1']
  c[label='@@2-2']
  d[label='@@2-3']
  e[label='@@2-4']
  f[label='@@2-5']
  g[label='@@2-6']
  h[label='@@2-7']
  i[label='@@2-8']
  j[label='@@2-9']

  #edge definitions with the node IDs
  a->{b c d e f g h i j}
  }
  
  [1]: 'top'
  [2]: 10:20
      ")


#----------------------
#graphiz susbstitution example 2

grViz("
digraph nicegraph {
  
  #graph, node, and edge definitions
  graph [compound=true, nodesep= .5, ranksep= .25,
          color=crimson]
  
  node [fontname=Helvetica, fontcolor= darkslategray,
        shape=rectangle, fixedsize=true, width=1,
        color = darkslategray]
  
  edge [color=grey, arrowhead=none, arrowtail=none]
  
  #subgraph for R information
  subgraph cluster0 {
    node [fixedsize=true, width=3]
    '@@1-1' -> '@@1-2' -> '@@1-3' -> '@@1-4'
    '@@1-4' -> '@@1-5' -> '@@1-6' -> '@@1-7'
  }
  
  #subgraph for RStudio information
  subgraph cluster1 {
    node [fixedsize = true, width=3]
    '@@2' -> '@@3'
  }
  
  Information [width=1.5]
  Information -> R
  Information -> RStudio
  R -> '@@1-1'  [lhead = cluster0]
  RStudio -> '@@2'  [lhead = cluster1]

}
  [1]: paste0(names(R.Version())[1:7], ':\\n ', R.Version()[1:7])
  [2]: paste0('RStudio version:\\n ', rstudioapi::versionInfo()[[1]])
  [3]: paste0('Current program mode:\\n ', rstudioapi::versionInfo()[[2]])
")



#---------------------
#Graphviz Layouts
#..................................

#----DOT Graph---------

grViz("
digraph dot{
  
  #==> Default: make up to down networkgraph
  graph [layout=dot]
  
  node [shape = circle,
        style = filled,
        color = grey,
        label = '']
        
  node [fillcolor = red]
  a
  
  node [fillcolor = green]
  b c d
  
  node [fillcolor = orange]
  
  edge [color = grey]
  a->{b c d}
  b-> {e f g h i j}
  c -> {k l m n o p}
  d -> {q r s t u v}
}

")


#------------ left to right graph
grViz("
digraph dot{
      
      #==> rankdir = LR ==> make left to right node graph
      graph [layout=dot
             rankdir = LR]
      
      node [shape = circle,
      style = filled,
      color = grey,
      label = '']
      
      node [fillcolor = red]
      a
      
      node [fillcolor = green]
      b c d
      
      node [fillcolor = orange]
      
      edge [color = grey]
      a->{b c d}
      b-> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}
      }
      
      ")


#-----NEATO GRAPH------

grViz("
digraph neato{
  
  graph [layout = neato]

  node [shape = circle,
        style = filled,
        color = grey,
        label = '']

      node [fillcolor = red]
      a
      
      node [fillcolor = green]
      b c d
      
      node [fillcolor = orange]
      
      edge [color = grey]
      a->{b c d}
      b-> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}

}
      ")


#-----TWOPI GRAPH------

grViz("
      digraph twopi{
      
      graph [layout = twopi]
      
      node [shape = circle,
      style = filled,
      color = grey,
      label = '']
      
      node [fillcolor = red]
      a
      
      node [fillcolor = green]
      b c d
      
      node [fillcolor = orange]
      
      edge [color = grey]
      a->{b c d}
      b-> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}
      
      }
      ")

#-----CIRCO GRAPH------

grViz("
      digraph circo{
      
      graph [layout = circo]
      
      node [shape = circle,
      style = filled,
      color = grey,
      label = '']
      
      node [fillcolor = red]
      a
      
      node [fillcolor = green]
      b c d
      
      node [fillcolor = orange]
      
      edge [color = grey]
      a->{b c d}
      b-> {e f g h i j}
      c -> {k l m n o p}
      d -> {q r s t u v}
      
      }
      ")



#---------------------------
# Mermaid Diagram
# With it, you can describe graphs and sequence diagrams.

# [Examples]

#..... Left to Right graph....
mermaid("
graph LR
    A-->B
  A-->C
  C-->E
  B-->D
  C-->D
  D-->F
  E-->F
")

#........Top to down graph....
mermaid("
graph TB
        A-->B
        A-->C
        C-->E
        B-->D
        C-->D
        D-->F
        E-->F
        ")

mermaid("graph.mmd")



#--------------------------
#Node Shape and Text
#------------------

mermaid("
graph LR
A(Rounded)-->B[Rectangular]
B-->C{A Rhombus}
C-->D[Rectangle One]
C-->E[Rectangle Two]
        ")
# () shape shows rounded rectangle 
# [] shape shows rectangle
# {} shape shows diamond shape


#-------------------
#Mermaid sequence Diagram
#------------------

mermaid ("
sequenceDiagram
  customer->>ticket seller: ask ticket
  ticket seller->>database: seats
  alt tickets available
    database->>ticket seller: ok
    ticket seller->>customer:confirm
    customer->>ticket seller: ok
    ticket seller->>database: book a seat
    ticket seller->>printer: print ticket
  else sold out
    database->>ticket seller: none left
    ticket selller->>customer: sorry
  end
         ")