source("https://goo.gl/q1JFih")
writeLines(as.character(net[[1]]))

#assign colors
x=cut_number(as.integer(net %v% "year"), 4)
writeLines(as.character(x[50:70]))
col=c("#E1AF00", "#EBCC2A", "#78B7C5", "#3B9AB2")
names(col) = levels(x)



ggnet2(net, color=x, color.legend="period", palette=col,
       edge.alpha = 1/4 , edge.size ="weight",
       size="outdegree", max_size =4, size.cut =3,
       legend.size=12, legend.position = "bottom") +
  coord_equal()
