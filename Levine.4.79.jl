

# Decleration
m =   0::Int64 # Number of Intervals
nn =  0::Int64 # The Number of Nodes

x = Array{Float64}(undef, 1000) # The Positions list
g = Array{Float64}(undef, 1000) # The G = 2Vr - 2E
p = Array{Float64}(undef, 1000) # The Psi 
E =   0.::Float64
s =   0.::Float64
ss =  0.::Float64

# The Inputs
print("Enter Initial xr \t\t\t\t\t> "); x[1] = parse(Float64, readline())
print("Enter the increment sr \t\t\t\t\t> "); s = parse(Float64, readline())
print("Enter the Number of Intervals m \t\t\t> "); m = parse(Int64, readline())
print("Enter the Reduced Energy Er (enter 1e10 to quit) Er \t> "); E = parse(Float64, readline())

# The first Control
if E > 1e10
    println("Quiting!!!")
    return 0
end

# Initialization
nn = 0 # The starting point for Number of Nodes
p[1] = 0 # The First Psi function value
p[2] = 0.0001 # The Second Psi function value
x[2] = x[1]+s # The Second value of the Position
g[1] = x[1]^2 - 2E
g[2] = x[2]^2 - 2E
ss = (s^2) / 12

for i in 2:m
    global x, g, p, E, s, ss, nn
    x[i+1] = x[i] + s
    g[i+1] = x[i+1]^2 - 2E
    p[i+1] = (-p[i-1] + 2p[i] + 10*g[i]*p[i]*ss + g[i-1]*p[i-1]*ss) / (1 - g[i+1]*ss)

    if p[i + 1] * p[i] < 0 # It changed its sign, so the Number nodes goes up
        nn += 1
    end
end

len = length("|Psir(xm) = $(p[m+1])\n")
print("\n$("_"^len)")
print("\n|Er = $E\n|Nodes = $nn\n|Psir(xm) = $(p[m+1])\n")

