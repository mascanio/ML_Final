function porcentaje = porcentajeAciertosBayes(pp, X, y)
	m = length(X(:,1));

	mm = max(pp')';
	aciertos = 0;
	for i = 1:m
		if (find(mm(i) == pp(i,:)) == y(i)) 
			aciertos++;
		endif	
	endfor

	porcentaje = aciertos / m * 100;
	

endfunction
