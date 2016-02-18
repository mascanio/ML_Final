function representaCurvaLambda(data)

for i = 1:size(data)(2);
	lambda(i) = data(i).lambda;
	errEntren(i) = 	data(i).errTrain;
	errVal(i) = data(i).errVal;
	porcentajeEntren(i) = data(i).porcentajeEntren;
	porcentajeTest(i) = data(i).porcentajeTest;
endfor

cla;

% Lambda/err %

figure(gcf + 1);

hold on;
plot(lambda, errEntren, 'color', 'blue');
plot(lambda, errVal, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Error");
xlabel ("Lambda");

hold off;

% Num entrenamiento/porcentajeAciertos %

figure(gcf + 1);

hold on;
plot(lambda, porcentajeEntren, 'color', 'blue');
plot(lambda, porcentajeTest, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Porcentaje aciertos");
xlabel ("Lambda");

hold off;

endfunction
