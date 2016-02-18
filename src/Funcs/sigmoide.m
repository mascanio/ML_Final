function s = sigmoide(z)

	zNeg = 0 .- z;

	s = 1./(1+e.^(zNeg));

endfunction
