function porcentaje = porcentajeAciertos (y, yPred) 

m = size(y)(1);
aciertos = 0;

for i = 1:m
	iterActual = yPred(:,i);
	mx = max(iterActual);
	if(find(iterActual == mx) == y(i)) 
		aciertos++;
	endif
endfor

porcentaje = aciertos / m * 100;

endfunction
