
valoresC = [1,3,5,8];
valoresSigma = [2,3,5,8];

for i = valoresC
for j = valoresSigma

	actual = dataSave(i,j);
	visualizeBoundary(X,y,actual.model);

	titulo = sprintf("C = %.2f | sigma = %.2f | aciertos = %.2f%%", actual.C, actual.sigma, actual.porcentaje);
	title(titulo);

	archivo = sprintf("plot_C%.2f_s%.2f.png", actual.C, actual.sigma);
	print("-dpng", archivo);
endfor
endfor
