using Test
using Graphs
import GraphGenRefImpl as g

@testset "LatticeGeneration" verbose = true begin
    @testset "branch = 2" begin
        branch = 2

        ngen0 = g.nnodes_diamond(0, branch)
        @test ngen0 == 2
        gen0 = g.adjmat_diamond(0, branch) |> g.to_fadjlist_graph
        @test gen0 isa AbstractGraph

        ngen1 = g.nnodes_diamond(1, branch)
        @test ngen1 == 4
        gen1 = g.adjmat_diamond(1, branch) |> g.to_fadjlist_graph
        @test gen1 isa AbstractGraph

        ngen2 = g.nnodes_diamond(2, branch)
        @test ngen2 == 12
        gen2 = g.adjmat_diamond(2, branch) |> g.to_fadjlist_graph
        @test gen2 isa AbstractGraph
    end

    @testset "branch = 3" begin
        branch = 3

        ngen0 = g.nnodes_diamond(0, branch)
        @test ngen0 == 2
        gen0 = g.adjmat_diamond(0, branch) |> g.to_fadjlist_graph
        @test gen0 isa AbstractGraph

        ngen1 = g.nnodes_diamond(1, branch)
        @test ngen1 == 2+branch
        gen1 = g.adjmat_diamond(1, branch) |> g.to_fadjlist_graph
        @test gen1 isa AbstractGraph

        ngen2 = g.nnodes_diamond(2, branch)
        @test ngen2 == 2 + branch + 6 * branch
        gen2 = g.adjmat_diamond(2, branch) |> g.to_fadjlist_graph
        @test gen2 isa AbstractGraph
    end
end
