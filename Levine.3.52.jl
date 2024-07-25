energy = 60 # For cubic box: E * (8ma^2)/h^2

eDic = Dict() # dictionary of energies related to nx, ny, nz
for nx in 1:energy
    for ny in 1:energy
        for nz in 1:energy
            e = nx^2 + ny^2 + nz^2
            if e <= energy
                if e in keys(eDic)
                    push!(eDic[e], [nx, ny, nz])
                else
                    eDic[e] = [[nx, ny, nz]] 
                end
            end
        end
    end
end

ke = keys(eDic)
e = []
for i in ke
    push!(e, i)
end
e = sort(e)


for i in e
    print("Energy : $i\n")  
    c = 0
    for j in eDic[i]
        c += 1
        print("\t$c: $(j[1]), $(j[2]), $(j[3])\n")
    end
    println("\t\tDegeneracy: $c")
end
