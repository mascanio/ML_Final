function r = derSigmoide(z) 
	s = sigmoide(z);
	#s = [ones(1, length (s)); s];
	r = s .* (1 - s);
endfunction
