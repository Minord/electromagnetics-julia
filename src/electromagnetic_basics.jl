using LinearAlgebra

const ε0 = 8.8541878128e-12
const μ0 = 4e-7*π

const k_coulomb = 1 / (4π*ε0)
const m_magnetic = 1 / (2π*μ0)

const V = 1.0
const mV = 1.0e-3
const μV = 1.0e-6
const nV = 1.0e-12

const C = 1.0
const mC = 1.0e-3
const μC = 1.0e-6
const nC = 1.0e-12

#Think on best names for this
function integrate_vec(r⃗ᵢ, r⃗)
    Σ = 0.0
    for r⃗₀ in r⃗ᵢ
        Σ += (r⃗ - r⃗₀) / norm(r⃗ - r⃗₀)
    end
    Σ
end

function intergrate_scalar(r⃗ᵢ, r⃗)
    Σ = 0.0
    for r⃗₀ in r⃗ᵢ
        Σ += 1 / norm(r⃗ - r⃗₀)
    end
    Σ
end

function electric(q, r⃗ᵢ::Vector, r⃗)
    k_coulomb * q * integrate_vec(r⃗ᵢ, r⃗)
end

function potencial(q, r⃗ᵢ::Vector, r⃗)
    k_coulomb * q * integrate_scalar(r⃗ᵢ, r⃗)
end

function electric(q, r⃗₀, r⃗)
    k_coulomb * q * (r⃗ - r⃗₀) / norm(r⃗ - r⃗₀)^3
end

function potencial(q, r⃗₀, r⃗)
    k_coulomb * q / norm(r⃗ - r⃗₀)
end

