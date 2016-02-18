function representaGraficaLambdaLog(dataSave) 

for i=1:size(dataSave.normal)(2)

	lambda(i) = dataSave.tfidf(i).lambda;

	porcentajeVal(i) = dataSave.normal(i).porcentajeVal;
	porcentajeEnt(i) = dataSave.normal(i).porcentajeEnt;

	porcentajeValtfidf(i) = dataSave.tfidf(i).porcentajeVal;
	porcentajeEnttfidf(i) = dataSave.tfidf(i).porcentajeEnt;

endfor
plot(lambda, porcentajeEnttfidf, 'color', 'b');
hold on;
plot(lambda, porcentajeValtfidf, 'color', 'g');

plot(lambda, porcentajeEnt, 'color', 'red');
plot(lambda, porcentajeVal, 'color', 'black');
hold off;
endfunction
