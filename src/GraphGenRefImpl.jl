module GraphGenRefImpl

using SparseArrays
using Graphs

include("AdjmatGraph.jl")

nedges_diamond(generation, branch) = (2branch)^generation

function nnodes_diamond(generation, branch)
    n_nodes = 2
    n_edges = 1

    for gen = 1:generation
        n_nodes += branch * n_edges
        n_edges = (2*branch)^gen
    end

    n_nodes
end

function adjmat_diamond(generation, branch)
    n_nodes = nnodes_diamond(generation, branch)
    graph = AdjmatGraph(n_nodes)

    # Instantiate generation zero
    newnodes = insert_nodes!(graph, 2)
    if isnothing(newnodes)
        @error "Unable to add new nodes to graph"
        return nothing
    end
    insert_edge!(graph, newnodes[1], newnodes[2])

    nedges = nedges_diamond(max(0, generation - 1), branch)
    removed_edges = Vector{ Tuple{Int64, Int64} }(undef, nedges)

    for gen = 1:generation
        redges_ptr = 1
        n_start, n_end, _ = findnz(adjmat(graph))

        for edge in zip(n_start, n_end)
            if edge[1] > edge[2]
                continue
            end

            newnodes = insert_nodes!(graph, branch)
            for newnode in newnodes
                insert_edge!(graph, edge[1], newnode)
                insert_edge!(graph, newnode, edge[2])
            end

            removed_edges[redges_ptr] = edge
            redges_ptr += 1
        end

        remove_edges!(graph, @view removed_edges[1:redges_ptr-1])

    end

    graph
end

end # module GraphGenRefImpl
