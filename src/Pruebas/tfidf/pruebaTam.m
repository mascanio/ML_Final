addpath Funcs/;
clear;
% Párametros del test %
fixed_test_m = 329;
step = 100;

num_etiquetas = 5;
numItersMax = 25;
lambda = 10;
min = 200;
mtrain = 850;

i=1;
for num_ocultas = 5:5:200

% Carga estática de datos %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);

num_etiquetas = 5;
numItersMax = 25;
lambda = 10;
m = size(X)(1);

Xtest = X(mtrain+1:end,:);
ytest = y(mtrain+1:end);
X_test_unos =  [ones(size(Xtest)(1), 1), Xtest];

ThetaIni1 = pesosAleatorios(num_entradas,num_ocultas);
ThetaIni2 = pesosAleatorios(num_ocultas,num_etiquetas);
thetaIni = [ThetaIni1(:); ThetaIni2(:)];

opciones = optimset ('Gradobj', 'on', 'MaxIter', numItersMax);


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

save dataSavePruebaTam dataSave;
