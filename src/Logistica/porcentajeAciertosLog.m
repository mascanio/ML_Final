function porcentaje = porcentajeAciertosLog(theta, X, y)
	m = length(X(:,1));

	valoresH = (theta' * X')';
	h = sigmoide(valoresH);


	mm = max(h')';
	aciertos = 0;
	for i = 1:m
		if (find(mm(i) == h(i,:)) == y(i)) 
			aciertos++;
		endif	
	endfor

	porcentaje = aciertos / m * 100;
	

endfunction
