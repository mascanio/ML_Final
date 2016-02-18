function representaCurvaLambda(data)

for i = 1:size(data)(2);
	iter(i) = data(i).iter;
	errEntren(i) = 	data(i).errTrain;
	errVal(i) = data(i).errVal;
	porcentajeEntren(i) = data(i).porcentajeEntren;
	porcentajeTest(i) = data(i).porcentajeTest;
endfor

cla;

% iter/err %
hold on;
plot(iter, errEntren, 'color', 'blue');
plot(iter, errVal, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Error");
xlabel ("iter");

hold off;

% iter/porcentajeAciertos %

figure(gcf + 1);

hold on;
plot(iter, porcentajeEntren, 'color', 'blue');
plot(iter, porcentajeTest, 'color', 'green');

title ("Curva de aprendizaje");
ylabel ("Porcentaje aciertos");
xlabel ("iter");

hold off;

endfunction
