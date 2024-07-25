using Plots

x = 0:0.01:1
y = 0:0.02:2
z = 0:0.03:3
psi = [sin.(pi .* x ./ x[end]) sin.(2pi .* y ./ y[end]) sin.(3pi .* z ./ z[end])]

println(psi[1])
println(psi[2])
println(psi[3])
println(ndims(psi))

xlabel!("x")
ylabel!("y")
zlabel!("z")
plot(psi)
