addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;
lambda = 10;
numItersMax = 100;
num_ocultas = 50;
lambda = 1;

step = 10;
num_etiquetas = 5;
min = 0;
% Carga estática de datos %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2); # Number of features

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);
X_train_unos = [ones(mtrain, 1), Xtrain];

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);
X_train_unos = [ones(mtrain, 1), Xtrain];

Xval = X(mtrain+1:end,:);
yval = y(mtrain+1:end);
X_val_unos =  [ones(size(Xval)(1), 1), Xval];

ThetaIni1 = pesosAleatorios(num_entradas,num_ocultas);
ThetaIni2 = pesosAleatorios(num_ocultas,num_etiquetas);
thetaIni = [ThetaIni1(:); ThetaIni2(:)];


thetaProc = thetaIni;
i=1;
for iter = step:step:numItersMax
	printf("Iteración i: %d, iteraciones: %d\n", i,iter);	
	tic()
	opciones = optimset ('Gradobj', 'on', 'MaxIter', step);
	dataSave(i).iter = iter;

	funCosteTrain = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain, lambda));
	funCosteVal = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_val_unos, yval, lambda));
	errTrain = @(p)(err(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain));
	errVal = @(p)(err(p, num_entradas, num_ocultas, num_etiquetas, X_val_unos, yval));

	% Entrena %
	[thetaProc, cost] = fmincg (funCosteTrain, thetaProc, opciones);
	
	% Guarda datos %
	[dataSave(i).costeEntren void] = funCosteTrain(thetaProc);
	[dataSave(i).costeVal void] = funCosteVal(thetaProc);

	dataSave(i).errTrain = errTrain(thetaProc);
	dataSave(i).errVal = errVal(thetaProc);

	ThetaProc1 = reshape(thetaProc(1:num_ocultas * (num_entradas + 1)), ... 
		num_ocultas, (num_entradas + 1));
	ThetaProc2 = reshape(thetaProc((1 + (num_ocultas * (num_entradas + 1))):end), ...
		num_etiquetas, (num_ocultas + 1));

	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_train_unos);
	dataSave(i).porcentajeEntren = porcentajeAciertos(ytrain, yPred);
	dataSave(i).porcentajeEntren;
	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_val_unos);
	dataSave(i).porcentajeTest = porcentajeAciertos(yval, yPred);
	dataSave(i).porcentajeTest;
	
	i++;	
	toc()
endfor

save dataSavePruebaIters dataSave;
