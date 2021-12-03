#=
# Some basic formulas and integrators for Electro Statics
=#


"""
Calculate the Electric field in a point 
in space of one or more charges particles
"""
#Electric Field of a single charge
function electric(q, r⃗₀, r⃗)
    k_coulomb * q * (r⃗ - r⃗₀) / norm(r⃗ - r⃗₀)^3
end

#Electric Field of multiple equal charges
function electric(q, r⃗ᵢ, r⃗)
    Σ = fill(0.0, length(r⃗))
    for r⃗₀ in r⃗ᵢ
        Σ += (r⃗ - r⃗₀) / norm(r⃗ - r⃗₀)^3
    end
    k_coulomb * q * Σ 
end

#Electric Field of mutiple diferent charges
function electric(qᵢ, r⃗ᵢ, r⃗)
    Σ = fill(0.0, length(r⃗))
    for i in 1:length(r⃗ᵢ)
        q₀ = qᵢ[i]
        r⃗₀ = r⃗ᵢ[i]
        Σ += q₀ * ((r⃗ - r⃗₀) / norm(r⃗ - r⃗₀)^3)
    end
    k_coulomb * Σ
end

"""
Calculate the Potencial in a point
in space of one or more charges particles
"""

#Potencial of a single point charge in a point of space
function potencial(q, r⃗₀, r⃗)
    k_coulomb * q * 1 / norm(r⃗ - r⃗₀)
end

#Potencial of a space point of serveral points with the
#same charge
function potencial(q, r⃗ᵢ, r⃗)
    Σ = 0.0 
    for r⃗₀ in r⃗ᵢ
        Σ += 1 / norm(r⃗ - r⃗₀)
    end
    k_coulomb * q * Σ
end

#Potencial of a space point and serveral diferent charges
function potencial(qᵢ, r⃗ᵢ, r⃗)
    Σ = 0.0
    for i = 1:length(r⃗ᵢ)
        q₀ = qᵢ[i]
        r⃗₀ = r⃗ᵢ[i]
        Σ += q₀ / norm(r⃗ - r⃗₀)
    end
    k_coulomb * Σ
end
