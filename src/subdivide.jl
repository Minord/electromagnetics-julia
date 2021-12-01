using LinearAlgebra

function cuts(order)
    1 + 2*order
end

function interpolate_absisas(order)
    cut_points = cuts(order)
    Δt = 1.0 / cut_points
    t = fill(Δt, cut_points)
    t[1] = 1/2 * Δt
    t = cumsum(t)
end

function interpolate_absisas(orden, n)
    fill(interpolate_absisas(orden), n)
end

function cartesian_product(a, b)
    w, h = length(a), length(b)
    product = fill([0.0, 0.0], (w, h))
    for i = 1:w
        for j = 1:h
            product[i, j] = [a[i], b[j]]
        end
    end
    product
end

function cartesian_product(a, b, c)
    w, h, v = length(a), length(b), length(c)
    product = fill([0.0, 0.0, 0.0], (w, h, v))
    for i = 1:w
        for j = 1:h
            for k = 1:v
                product[i, j, k] = [a[i], b[j], c[k]]
            end
        end
    end
    product
end

function triangular_test(r)
    r ⋅ fill(-1, length(r)) + 1>= 0
end

function get_triangular(matrix)
    vector = Vector{AbstractFloat}[]
    for r in matrix
        if triangular_test(r)
            push!(vector, r)
        end
    end
    return vector
end


"""
Generate points were we subdivide a Line, 
Triangle, or a Tetrahedron we the first 
segment and the last one is half of the
rest

## Example:
´´´ julia-relp
julia> subdivide([1, 3])
[0.1, 0.07]
 [0.30, 0.07]
 [0.5, 0.07]
 ...
 [0.1, 0.64]
 [0.30, 0.64]
 [0.1, 0.78]

julia> #Can be use in with 1, 2, 3 parameter
julia> subdivide([1])
julia> subdivide([2, 2])
julia> subdivide([2, 2, 3])
julia> #That is the sane as
julia> subdivide(1)
julia> subdivide(2, 2)
julia> subdivide(2, 2, 3)
´´´
"""
function subdivide(orders)
    nsize = length(orders)
    if nsize == 1
        return interpolate_absisas(orders[1])
    else
        absisas = interpolate_absisas.(orders)
        cartesian = cartesian_product(absisas...)
        triangle_test = get_triangular(cartesian)
        return triangle_test
    end
    interpolate_absisas(0)
end

function subdivide(order::Integer)
    subdivide([order])
end

function subdivide(orderx::Integer, ordery::Integer)
    subdivide([orderx, ordery])
end

function subdivide(orderx::Integer, ordery::Integer, orderz::Integer)
    subdivide([orderx, ordery, orderz])
end


