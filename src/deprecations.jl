using Base: depwarn


function _nv(g)
    depwarn("`GraphPlot._nv(g)` is deprecated. Use `Graphs.nv(g)` instead.", :_nv)
    return Graphs.nv(g)
end

function _ne(g)
    depwarn("`GraphPlot._ne(g)` is deprecated. Use `Graphs.ne(g)` instead.", :_ne)
    return Graphs.ne(g)
end

function _vertices(g)
    depwarn("`GraphPlot._vertices(g)` is deprecated. Use `Graphs.vertices(g)` instead.", :_vertices)
    return Graphs.vertices(g)
end

function _edges(g)
    depwarn("`GraphPlot._edges(g)` is deprecated. Use `Graphs.edges(g)` instead.", :_edges)
    return Graphs.edges(g)
end

function _src_index(e, g)
    depwarn("`GraphPlot._src_index(g)` is deprecated. Use `Graphs.src(e)` instead.", :_src_index)
    return Graphs.src(e)
end

function _dst_index(e, g)
    depwarn("`GraphPlot._dst_index(g)` is deprecated. Use `Graphs.dst(e)` instead.", :_dst_index)
    return Graphs.dst(e)
end

function _adjacency_matrix(g)
    depwarn("`GraphPlot._adjacency_matrix(g)` is deprecated. Use `Graphs.adjacency_matrix(g)` instead.", :_adjacency_matrix)
    return Graphs.adjacency_matrix(g)
end

function _is_directed(g)
    depwarn("`GraphPlot._is_directed(g)` is deprecated. Use `Graphs.is_directed(g)` instead.", :_is_directed)
    return Graphs.is_directed(g)
end

function _laplacian_matrix(g)
    depwarn("`GraphPlot._laplacian_matrix(g)` is deprecated. Use `Graphs.laplacian_matrix(g)` instead.", :_laplacian_matrix)
    return Graphs.laplacian_matrix(g)
end


"""
read some famous graphs

**Paramenters**

*graphname*
Currently, `graphname` can be one of ["karate", "football", "dolphins",
"netscience", "polbooks", "power", "cond-mat"]

**Return**
a graph

**Example**
    julia> g = graphfamous("karate")
"""
function graphfamous(graphname::AbstractString)
     depwarn("""
             `graphfamous` has been deprecated and will be removed in the future. Consider the package `GraphIO.jl` for loading graphs.
            """, :graphfamous)
    file = joinpath(dirname(@__DIR__), "data", graphname*".dat")
    readedgelist(file)
end
export graphfamous

using DelimitedFiles: readdlm
"""read graph from in edgelist format"""
function readedgelist(filename; is_directed::Bool=false, start_index::Int=0, delim::Char=' ')
    depwarn("""
             `graphfamous` has been deprecated and will be removed in the future. Consider the package `GraphIO.jl` for loading graphs.
            """, :graphfamous)
    es = readdlm(filename, delim, Int)
    es = unique(es, dims=1)
    if start_index == 0
        es = es .+ 1
    end
    N = maximum(es)
    if is_directed
        g = DiGraph(N)
        for i=1:size(es,1)
            add_edge!(g, es[i,1], es[i,2])
        end
        return g
    else
        for i=1:size(es,1)
            if es[i,1] > es[i,2]
                es[i,1], es[i,2] = es[i,2], es[i,1]
            end
        end
        es = unique(es, dims=1)
        g = Graph(N)
        for i=1:size(es,1)
            add_edge!(g, es[i,1], es[i,2])
        end
        return g
    end
end
export readedgelist
