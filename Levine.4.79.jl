using Plots

# Decleration
N = 1000 # Number of byte units for numbers
m =   0::Int64 # Number of Intervals
nn =  0::Int64 # The Number of Nodes
x = Array{Float64}(undef, N) # The Positions list
g = Array{Float64}(undef, N) # The G = 2Vr - 2E
p = Array{Float64}(undef, N) # The Psi 
E =   0.::Float64 # Energy guessed
s =   0.::Float64 # The incrementation
ss =  0.::Float64 # s^2 / 12

# Functions for Each system of Numerov
function pib()

    # the inputs
    print("the first position:\n\tx[1] = 0\n")
    x[1] = 0

    print("enter the number of intervals m \n(ex: 100)> "); m = parse(int64, readline())

    print("the incrementation:\n\ts = $(1/m)\n")
    s = 1 / m
    
    print("enter the reduced energy er (enter 1e10 to quit) er \n> "); e = parse(float64, readline())

    # the first control
    if e >= 1e10
        println("quiting!!!")
        return 0
    end

    # initialization
    nn = 0 # the starting point for number of nodes
    p[1] = 0 # the first psi function value
    p[2] = 0.0001 # the second psi function value
    x[2] = x[1]+s # the second value of the position
    g[1] = x[1]^2 - 2e
    g[2] = x[2]^2 - 2e
    ss = (s^2) / 12

    
    # numerov algorithm
    for i in 2:m-1
        x[i+1] = x[i] + s
        g[i+1] = -2e              # only for particle in a box with infinite potential wall at 0 and l (vr = 0)
        p[i+1] = (-p[i-1] + 2p[i] + 10*g[i]*p[i]*ss + g[i-1]*p[i-1]*ss) / (1 - g[i+1]*ss)

        if p[i+1] * p[i] < 0 # it changed its sign, so the number nodes goes up
            nn += 1
        end
    end

    return m, nn, x, p, e 
end


function HarmonicOscillator()



    # The Inputs
    print("Enter Initial xr \n> "); x[1] = parse(Float64, readline())

    print("Enter the Number of Intervals m \n(ex: 100)> "); m = parse(Int64, readline())
    
    print("Enter the increment sr \n(ex: 0.1)> "); s = parse(Float64, readline())

    print("Enter the Reduced Energy Er (enter 1e10 to quit) Er \n> "); E = parse(Float64, readline())
    

    # The first Control
    if E >= 1e10
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
    
    # The Numerov Algorithm
    for i in 2:m-1
        x[i+1] = x[i] + s
        g[i+1] = x[i+1]^2 - 2E    # Only for Harmonic Oscilator (Vr = x^2)
        p[i+1] = (-p[i-1] + 2p[i] + 10*g[i]*p[i]*ss + g[i-1]*p[i-1]*ss) / (1 - g[i+1]*ss)

        if p[i+1] * p[i] < 0 # It changed its sign, so the Number nodes goes up
            nn += 1
        end
    end    
    
    return m, nn, x, p, E
end


# The System of choice
print("The system? \n\tHarmonic Oscillator: ho, \n\tParticle in Box: pib\n> "); system = readline()


if system == "pib"
    ans = PIB()
elseif system == "ho"
    ans = HarmonicOscillator()
end

println("m: $(ans[1])")
println("nn: $(ans[2])")
println("x: $(ans[3])")
println("p: $(ans[4])")
println("E: $(ans[5])")

# The Result Part
len = length("|Psir(xm) = $(ans[4][ans[1]])\n")
print("\n$("_"^len)")
print("\n|Er = $(ans[5])\n|Nodes = $(ans[2])\n|Psir(xm) = $(ans[4][ans[1]])\n")


# The Plotting Part
pl = plot(ans[3][1:ans[1]], ans[4][1:ans[1]])
xlabel!("x")
ylabel!("ψ")

display(pl)
while true
    print("Press ENTER to end the Program."); q = readline()
    break
end


