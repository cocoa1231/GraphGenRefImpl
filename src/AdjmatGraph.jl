mutable struct AdjmatGraph{Tv,Ti}
    adjmat::SparseMatrixCSC{Tv,Ti}
    len::Ti
    cap::Ti
end
Base.length(a::AdjmatGraph) = a.len
capacity(a::AdjmatGraph) = a.cap
adjmat(a::AdjmatGraph) = a.adjmat

function AdjmatGraph(capacity)
    AdjmatGraph(
        spzeros(Int8, capacity, capacity),
        0,
        capacity
    )
end

function insert_nodes!(adjmatgraph::AdjmatGraph, num_nodes)
    if length(adjmatgraph) + num_nodes > capacity((adjmatgraph))
        @error "Unable to insert $num_nodes nodes as it will exceed graph capacity $(capacity(adjmatgraph))", length(adjmatgraph)
        return nothing
    end

    nodes_added = 1+length(adjmatgraph):length(adjmatgraph)+num_nodes
    adjmatgraph.len += num_nodes

    return nodes_added
end
nodes(a::AdjmatGraph) = 1:length(a)
function edges(a::AdjmatGraph)
    n_start, n_end, _ = findnz(adjmat(a))
    return (Edge(x) for x in zip(n_start, n_end))
end

function insert_edge!(adjmatgraph::AdjmatGraph, n_start, n_end)
    if n_start > length(adjmatgraph) || n_end > length(adjmatgraph)
        @error "Unable to connect nonexistent nodes ($n_start, $n_end)"
        return nothing
    end

    f = min(n_start, n_end)
    e = max(n_start, n_end)
    adjmatgraph.adjmat[f, e] = 1

    (f, e)
end

function remove_edges!(adjmatgraph::AdjmatGraph, edges)

    for (n_start, n_end) in edges
        s = min(n_start, n_end)
        e = max(n_start, n_end)
        adjmatgraph.adjmat[s, e] = 0
    end
    dropzeros!(adjmat(adjmatgraph))

end

@doc """
Convert AdjmatGraph to a standard Graphs.jl Graph.
Ideally, the graph should not mutate after this.
"""
function to_fadjlist_graph(AG::AdjmatGraph)
    edge_iter = edges(AG)
    SimpleGraphFromIterator(edge_iter)
end

function Graphs.SimpleGraph(AG::AdjmatGraph)
    return to_fadjlist_graph(AG)
end
