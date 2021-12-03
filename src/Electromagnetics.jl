module Electromagnetics

using Meshes
using LinearAlgebra
using Luxor

include("electric_basics.jl")
include("subdivide.jl")
include("charges_bodies.jl")

#export relevant constants
export ε₀, μ₀, c

export MV, kV, V, mV, μV, nV
export C, mC, μC, nC, pC
export F, mF, μF, nF, pF
export km, m, cm, mm, μm, nm, ̊A, pm

export electric, potencial
end
