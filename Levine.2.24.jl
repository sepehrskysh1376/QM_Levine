using Plots


V0 = 15.0 * 1.6021766e-19 # J
l = 2e-10 # m
m = 9.109e-31 # kg
ħ = 6.626e-34/(2*π) # J.s

b = sqrt(2 * m * V0) * l / ħ

ϵ = 0.0001:0.0001:1

y = (2 .* ϵ .- 1) .* sin.(b * sqrt.(ϵ)) .- 2 .* sqrt.(ϵ .- (ϵ.^2)) .* cos.(b .* sqrt.(ϵ))

yz = []
ϵz = []
for i in 1:length(y)-1
  s = y[i]/abs(y[i])
  if s != y[i+1]/abs(y[i+1])
    append!(yz, y[i+1])
    append!(ϵz, ϵ[i+1])
  end 
end

println("z = $yz")

default(show = true)
plot!(ϵ, y)
scatter!(ϵz, yz)
xlabel!("ϵ") 
ylabel!("Should be zero")



