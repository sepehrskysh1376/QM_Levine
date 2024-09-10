using Plots

# Decleration
m =   0::Int64 # Number of Intervals
nn =  0::Int64 # The Number of Nodes
x = Array{Float64}(undef, 100000) # The Positions list
g = Array{Float64}(undef, 100000) # The G = 2Vr - 2E
p = Array{Float64}(undef, 100000) # The Psi 
E =   0.::Float64
s =   0.::Float64
ss =  0.::Float64

# The Inputs
print("The system? \n\tOscillatro: o, \n\tbox with infinite wall: bi\n> "); system = readline()

if system == "bi"
    print("The First position:\n\tx[1] = 0\n")
    x[1] = 0
elseif system == "o"
    print("Enter Initial xr \n> "); x[1] = parse(Float64, readline())
end

print("Enter the Number of Intervals m \n(ex: 100)> "); m = parse(Int64, readline())

if system == "bi"
    print("The Incrementation:\n\ts = $(1/m)\n")
    s = 1 / m
elseif system == "o"
    print("Enter the increment sr \n(ex: 0.1)> "); s = parse(Float64, readline())
end

print("Enter the Reduced Energy Er (enter 1e10 to quit) Er \n> "); E = parse(Float64, readline())

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
if system == "o"
    g[1] = x[1]^2 - 2E
    g[2] = x[2]^2 - 2E
elseif system == "bi"
    g[1] = -2E
    g[2] = -2E
end

ss = (s^2) / 12

for i in 2:m-1
    global x, g, p, E, s, ss, nn
    x[i+1] = x[i] + s
    if system == "o"
        g[i+1] = x[i+1]^2 - 2E    # Only for Harmonic Oscilator (Vr = x^2)
    elseif system == "bi"
        g[i+1] = -2E              # Only for Particle in a box with infinite potential wall at 0 and l (Vr = 0)
    end
    p[i+1] = (-p[i-1] + 2p[i] + 10*g[i]*p[i]*ss + g[i-1]*p[i-1]*ss) / (1 - g[i+1]*ss)

    if p[i+1] * p[i] < 0 # It changed its sign, so the Number nodes goes up
        nn += 1
    end
end


# The Result Part
len = length("|Psir(xm) = $(p[m])\n")
print("\n$("_"^len)")
print("\n|Er = $E\n|Nodes = $nn\n|Psir(xm) = $(p[m])\n")


# The Plotting Part
pl = plot(x[1:m], p[1:m])
xlabel!("x")
ylabel!("ψ")

display(pl)
while true
    print("Press ENTER to end the Program."); ans = readline()
    break
end


