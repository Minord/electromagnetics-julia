using Meshes


Simplex = Union{Point, Segment, 
                Triangle, Tetrahedron}

dimsof(geom::Point) = 0
dimsof(geom::Segment) = 1
dimsof(geom::Triangle) = 2
dimsof(geom::Tetrahedron) = 3

struct ChargeBody
    charge :: AbstractFloat
    geom :: Simplex
end

function PointCharge(q, p)
    ChargeBody(q, p)
end

function LinearCharge(λ, segment)
    ChargeBody(λ, segment)
end

function LinearCharge(λ, p₁, p₂)
    ChargeBody(λ, Segment(p₁, p₂))
end

function SurfaceCharge(σ, triangle)
    ChargeBody(σ, triangle)
end

function SurfaceCharge(σ, p₁, p₂, p₃)
    TriangleCharge(σ, Triangle(p₁, p₂, p₃))
end

function VolumetricCharge(ρ, tetrahedron)
    ChargeBody(ρ, tetrahedron)
end

function VolumetricCharge(ρ, p₁, p₂, p₃, p₄)
    VolumetricCharge(ρ, Tetrahedron(p₁, p₂, p₃, p₄))
end

function f_order(x)
    if x < 0
        return 1
    elseif  x > 1
        return 0
    end
    (x - 1)^2
end

function g_order(distance)
    max = 5
    far = 2
    max * f_order(distance * 1/far)
end

function calculate_orders(geom, r⃗)  
    #In the case of this methods can be
    #Actual State:
    #   calculate de distances of the centrid of the geom
    #   and the vector r⃗. appñy the g_order function
    #   and make a vector of all equal orders
    #
    #Future state
    #   caculate the distance with a Signed distances function
    #   to Geom
    #   the for the triangle by the shape calculate optimal
    #   orders for each of the shapers for a most omegeneus
    #   sample points 
    center_geom = centroid(geom)
    distance = norm(center_geom.coords - r⃗)
    fill(g_order(distance), dimsof(geom))
end

#Not working
function electricfield(r⃗, charge)
    orders = calculate_orders(charge.geom, r⃗)
    sample = subdivide(orders)
    samples = geom.(sample)
    sum(electric_field.(samples, r⃗)
end
