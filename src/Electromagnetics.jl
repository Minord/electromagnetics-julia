module Electromagnetics

using Meshes
using LinearAlgebra
using Luxor

include("electric_basics.jl")
include("subdivide.jl")
include("charges_bodies.jl")


export electric, potencial

export ChargeBody, LinearCharge,
       SurfaceCharge, VolumetricCharge

export subdivide

export ε₀, μ₀
export k_coulomb
export m_magnetic

export MV kV V mV μV nV
export C mC μC nC

end
