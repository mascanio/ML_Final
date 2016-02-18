addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;

num_ocultas = 10;
lambda = 2;
iteraciones = 50;

num_etiquetas = 5;
min = 100; # Palabras que aparezcan menos de min veces se eliminaran
% Carga estática de datos %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2) # Number of features

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
opciones = optimset ('Gradobj', 'on', 'MaxIter', iteraciones);

	funCosteTrain = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain, lambda));

	% Entrena %
	[thetaProc, cost] = fminunc (funCosteTrain, thetaProc, opciones);

	ThetaProc1 = reshape(thetaProc(1:num_ocultas * (num_entradas + 1)), ... 
		num_ocultas, (num_entradas + 1));
	ThetaProc2 = reshape(thetaProc((1 + (num_ocultas * (num_entradas + 1))):end), ...
		num_etiquetas, (num_ocultas + 1));

	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_train_unos);
	porEnt = porcentajeAciertos(ytrain, yPred);
	printf("PorcentajeEntren = %.4f\n", porEnt);
	[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_val_unos);
	porVal = porcentajeAciertos(yval, yPred);
	printf("PorcentajeVal = %.4f\n", porVal);

