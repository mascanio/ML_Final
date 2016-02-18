function representaGraficaNumEntLog(dataSave) 

for i=1:size(dataSave.normal)(2)

	mtrain(i) = dataSave.tfidf(i).mtrain;

	porcentajeVal(i) = dataSave.normal(i).porcentajeVal;
	porcentajeEnt(i) = dataSave.normal(i).porcentajeEnt;

	porcentajeValtfidf(i) = dataSave.tfidf(i).porcentajeVal;
	porcentajeEnttfidf(i) = dataSave.tfidf(i).porcentajeEnt;

endfor
plot(mtrain, porcentajeEnttfidf, 'color', 'b');
hold on;
plot(mtrain, porcentajeValtfidf, 'color', 'g');

plot(mtrain, porcentajeEnt, 'color', 'red');
plot(mtrain, porcentajeVal, 'color', 'black');
hold off;
endfunction
