using Test

include("electromagnetic_basics.jl")
include("subdivide.jl")
include("charges_bodies.jl")


#Test the order function
r⃗ = [1.0, 1.0, 1.0]
p1 = Point(-1.0, -2.2, -3.0)
p2 = Point(0.0, 1.4, 2.4)
p3 = Point(2.0, -2.4, 3.2)
p4 = Point(1.0, 2.3, -1.2)

segment = Segment(p1, p2)
triangle = Triangle(p1, p2, p3)
tetrahedron = Tetrahedron(p1, p2, p3, p4)

@test size(calculate_orders(segment, r⃗))[1] == 1
@test size(calculate_orders(triangle, r⃗))[1] == 2
@test size(calculate_orders(tetrahedron, r⃗))[1] == 3
#Test the principal function subdivide

#Test the other function get_triangular
cartesian = cartesian_product(interpolate_absisas.([2,2])...)
@test [0.5, 0.5] ϵ get_triangular(cartesian)
@test length(get_triangular(cartesian)) == 15

#Test for triangular test

@test triangular_test([1.0/3, 1.0/3]) == true
@test triangular_test([0.5, 0.5]) == true
@test triangular_test([0.51, 0.51]) == false
@test triangular_test([1/4, 1/4, 0.5]) == true
@test triangular_test([(1-π)/(-2π), (1-π)/(-2π), 1/π]) == true

#Test for cartesian product
bicartesian = cartesian_product(interpolate_absisas.([3,3])...)

@test size(bicartesian) == (7,7)
@test bicartesian[4, 4] == [0.5, 0.5]

tricartesian = cartesian_product(interpolate_absisas.([3,3,3])...)

@test size(tricartesian) == (7, 7, 7)
@test tricartesian[4,4,4] == [0.5,0.5,0.5]

#Test for interpolate_absisas 
@test interpolate_absisas(0) ≈ [0.5]
@test interpolate_absisas(1) ≈ [1.0/3 - 1/6, 0.5, 1.0 - 1.0/6]

inter = interpolate_absisas(6)
@test length(inter) == 13
@test inter[7] == 0.5
@test inter[1] ≈ 1/(13*2)
@test inter[3] - inter[2] ≈ 1/13
@test inter[13] ≈ 1 - 1/(13*2)

inter1 = interpolate_absisas(4)
inter2 = interpolate_absisas(3)
inter3 = interpolate_absisas(2)
@test interpolate_absisas.([4, 3, 2]) ≈ [inter1, inter2, inter3] 


i = [1.0, 0.0, 0.0]
j = [0.0, 1.0, 0.0]
k = [0.0, 0.0, 1.0]
o = [0.0, 0.0, 0.0]

#Functions for test the Electric Froce function
E1 = electric(1, o, i)
E2 = electric(1C, o, j)
E3 = electric(1C, o, k)
E4 = electric(1C, o, -i)
E5 = electric(1C, o, -j)
E6 = electric(1C, o, -k)
@test norm(E1) == norm(E2) == norm(E3) == norm(E4) == norm(E5) == norm(E6)

i = [1.0, 0.0]
j = [0.0, 1.0]
o = [0.0, 0.0]

E1 = potencial(1C, o, i)
E2 = potencial(1C, o, j)
E3 = potencial(1C, o, -i)
E4 = potencial(1C, o, -j)

@test norm(E1) == norm(E2) == norm(E3) == norm(E4)

#Test for the electric Potencial Function
V1 = potencial(1C, o, i)
V2 = potencial(1C, o, j)
V4 = potencial(1C, o, -i)
V5 = potencial(1C, o, -j)

o = [0.0, 0.0, 0.0]
V3 = potencial(1C, o, k)
V6 = potencial(1C, o, -k)

@test V1 == V2 == V3 == V4 == V5 == V6
