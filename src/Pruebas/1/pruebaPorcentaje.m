addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;

num_ocultas = 50;
lambda = 0.1;
iteraciones = 160;

% Carga estática de datos %

load dmoz-web-directory-topics.mat;
X = full(data)';
y = label';
y = y.-4;

n = size(X)(2); # Number of features

clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
num_etiquetas = 5;
m = size(X)(1);

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
	[thetaProc, cost] = fmincg (funCosteTrain, thetaProc, opciones);

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

