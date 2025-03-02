# Adjacency Matrix Backed Graphs

This repository is a short reference implementation for creating adjacency Matrix
backed graphs of a pre-defined capacity and constructing hierarchical lattices
using them. A package with more capabilities will be released once ready.

You can use this example by cloning the repository and including `main.jl` in your
session. For instance, to create a generation 4 lattice with branching number $b=2$
you can do something like the following.

```julia
julia> import GraphGenRefImpl as g

julia> adjmat_graph = g.adjmat_diamond(5, 2) # generation 5 branch 2
GraphGenRefImpl.AdjmatGraph{Int8, Int64}(sparse([1, 45, 1, 45, 13, 45, 13, 45, 1, 46  …  44, 171, 12, 172, 12, 172, 44, 172, 44, 172], [173, 173, 174, 174, 175,
 175, 176, 176, 177, 177  …  680, 680, 681, 681, 682, 682, 683, 683, 684, 684], Int8[1, 1, 1, 1, 1, 1, 1, 1, 1, 1  …  1, 1, 1, 1, 1, 1, 1, 1, 1, 1], 684, 684), 
684, 684)

julia> g.to_fadjlist_graph(adjmat_graph)
{684, 1024} undirected simple Int64 graph
```


From there you can use it as a regular `Graphs.jl` graph.
