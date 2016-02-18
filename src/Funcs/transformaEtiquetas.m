function r = transformaEtiquetas(y, numEtiquetas) 

	r = zeros(length(y), numEtiquetas);

	for i = 1:size(y)
		r(i,y(i)) = 1;
	endfor	

endfunction
