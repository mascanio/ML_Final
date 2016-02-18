function representaGraficaPalabrasLog(dataSave) 

for i=1:size(dataSave)(2)

	palabras(i) = dataSave(i).min;
	porcentajeVal(i) = dataSave(i).porcentajeVal;
	porcentajeEnt(i) = dataSave(i).porcentajeEnt;
endfor

plot(palabras, porcentajeEnt, 'color', 'b');
hold on;
plot(palabras, porcentajeVal, 'color', 'g');
hold off;
endfunction
