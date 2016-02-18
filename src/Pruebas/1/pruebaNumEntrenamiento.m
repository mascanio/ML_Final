addpath Funcs/;
clear;
% Párametros del test %
fixed_test_m = 329;
step = 25;
% Carga estática de datos %

load dmoz-web-directory-topics.mat;
X = full(data)';
y = label';
y = y.-4;
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
num_ocultas = 150;
num_etiquetas = 5;
numItersMax = 75;
lambda = 0;
m = size(X)(1);

Xtest = X(end-fixed_test_m+1:end,:);
ytest = y(end-fixed_test_m+1:end);
X_test_unos =  [ones(fixed_test_m, 1), Xtest];

ThetaIni1 = pesosAleatorios(num_entradas,num_ocultas);
ThetaIni2 = pesosAleatorios(num_ocultas,num_etiquetas);
thetaIni = [ThetaIni1(:); ThetaIni2(:)];

opciones = optimset ('Gradobj', 'on', 'MaxIter', numItersMax);

i=1;
for mtrain = step:step:m-fixed_test_m
	printf("Iteración i: %d, mtrain: %d\n", i,mtrain);	
	tic()
	dataSave(i).numEntren = mtrain;

	Xtrain = X(1:mtrain,:);
	ytrain = y(1:mtrain);

	X_train_unos = [ones(mtrain, 1), Xtrain];

	func = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain, lambda));

	[thetaProc, cost] = fmincg (func, thetaIni, opciones);
	[dataSave(i).costeEntren void] = costeRN(thetaProc, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain, lambda);
	[dataSave(i).costeVal void] = costeRN(thetaProc, num_entradas, num_ocultas, num_etiquetas, X_test_unos, ytest, lambda);

	ThetaProc1 = reshape(thetaProc(1:num_ocultas * (num_entradas + 1)), ... 
		num_ocultas, (num_entradas + 1));
	ThetaProc2 = reshape(thetaProc((1 + (num_ocultas * (num_entradas + 1))):end), ...
		num_etiquetas, (num_ocultas + 1));

	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_train_unos);
	dataSave(i).porcentajeEntren = porcentajeAciertos(ytrain, yPred);
	dataSave(i).porcentajeEntren;
	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_test_unos);
	dataSave(i).porcentajeTest = porcentajeAciertos(ytest, yPred);
	dataSave(i).porcentajeTest;
	i++;	
	toc()
endfor

save dataSavePruebaNumEntrenamiento dataSave;
