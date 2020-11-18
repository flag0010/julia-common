#use e.g.
#include("Common.jl")
#Common.count_all()
module Common
import StatsBase

choose(n,k) = binomial(n,k) #trowaway b/c i'm used to "choose"

function get_file(INFILE, splitchar="\t")
    #read a file split on splitchar (default is tab)
    xfile = []
    open(INFILE) do file
        for ln in eachline(file)
            z = split(ln, splitchar)
            push!(xfile, z)
        end
    end
    return xfile 
end

function count_all(x; proportion=false)
    #use countmap, for cts, but with convenience func of returning proportions or counts using "proportion" flag
    d = StatsBase.countmap(x)
    if proportion
        d2 = Dict()
        for i in keys(d)
            d2[i] = d[i]/length(x)
        end
        return d2
    else
        return d
    end
end

function weighted_sampler(weightDict, n)
    #weighted sampler, where weightDict is a dict of key/value pairs where the value is numverical and rep the weights
    #n is the number of samples to draw
    tot = sum(values(weightDict))
    k = [i for i in keys(weightDict)]
    val = [weightDict[i] for i in k]
    w = StatsBase.pweights([i/tot for i in val])
    return StatsBase.sample(k, w, n)
end

function pairwise(li)  
    #a convienience function that produces all pairwise comparisons from a list
    out = []
    for i in 1:length(li)
        j = i+1
        while j <= length(li)
            push!(out, (li[i], li[j]))
            j += 1
        end
    end
    return out
end
end