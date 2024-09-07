using Plots

# The Initializations
alphax = collect(-4:0.1:4) # The (alpha)^1/2 * x

e = exp.((-(alphax).^2) ./ 2) # The exp(-(alpha * x^2) / 2)

E_hnu = [0.499, 0.5, 0.501]  # E / (h * freq)

plot()
for E in E_hnu
	println("----------------------------------")
	println("E: $E")

	c = [1.0] # The c's in the summation list (The first component is c0 which is removed by /c0)

	function recursion_relation(l)
		c2lplus2 = c[l+1] * ((1 + 4l - 2E) / ((2l + 1) * (2l + 2)))
		push!(c, c2lplus2)

		return c2lplus2
	end


	l = 0
	while true
		# The Test (The Accuracy)
		if abs(c[l+1]) < 1e-100
			print("Recursion had enough!!!\n")
			break
		end	
		recursion_relation(l)
		l += 1
	end


	sum = [] # summation of c2l * alpha^l * x^2l
	for x in 1:length(alphax)
		s = 0 # Starting point
		for i in 0:length(c)-1
			s += c[i+1] * (alphax[x])^2i
		end
		push!(sum, s)
	end


	si = sum .* e

	plot!(alphax, si, label="E/hν = $E")
	println("si: $si")
	println("xr: $alphax")
end
plot!(legend=:outerbottom, legendcolumns=3)
xlabel!("α1/2 * x")
ylabel!("ψ/c₀")
