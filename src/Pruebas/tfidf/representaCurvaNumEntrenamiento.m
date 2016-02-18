function representaCurvaNumEntrenamiento(data)

for i = 1:size(data)(2);
	mEntren(i) = data(i).numEntren;
	errorEntren(i) = data(i).costeEntren;
	errorVal(i) = data(i).costeVal;
	porcentajeEntren(i) = data(i).porcentajeEntren;
	porcentajeTest(i) = data(i).porcentajeTest;
endfor

% Num entrenamiento/coste %

cla;
hold on;
plot(mEntren, errorEntren, 'color', 'blue');
plot(mEntren, errorVal, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Error");
xlabel ("Numero de ejemplos de entrenamiento");

hold off;

% Num entrenamiento/porcentajeAciertos %

figure(gcf + 1);

hold on;
plot(mEntren, porcentajeEntren, 'color', 'blue');
plot(mEntren, porcentajeTest, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Porcentaje aciertos");
xlabel ("Numero de ejemplos de entrenamiento");

hold off;

endfunction
