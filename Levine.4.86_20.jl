println("The 4.20 Question from 4 Chapter of Levine Quantum Chemistry book.\n")

vx = 0; print("Set the vx:>"); vx = parse(Int64, readline()); print("\n")
vy = 0; print("Set the vy:>"); vy = parse(Int64, readline()); print("\n")
vz = 0; print("Set the vz:>"); vz = parse(Int64, readline()); print("\n")

QNum = Dict()
for i in 1:vx
    for j in 1:vy
        for l in 1:vz
            s = i + j + l
            if s in keys(QNum)
                push!(QNum[s], [i, j, l]) # The state: [vx, vj, vz]
            else
                QNum[s] = [[i, j, l]]
            end
        end
    end
end

TotalQNum = sort(collect(keys(QNum)))
for level in TotalQNum
    print("\nThe Energy level: $level (Number of states: $(length(QNum[level])))\n")
    print("\t\tvx\tvy\tvz\n")
    print("___________________________\n")
    c = 0
    for state in 1:length(QNum[level])
        c += 1
        x = QNum[level][state][1]
        y = QNum[level][state][2]
        z = QNum[level][state][3]
        print("\t$c:\t$x\t$y\t$z\n")
    end
end