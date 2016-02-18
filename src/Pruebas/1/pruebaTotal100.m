addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;

#num_ocultas_vals = [15, 50, 100, 200, 350, 600, 1000, 2000];
num_ocultas_vals = [100];

lambdaVals = [0.001,0.003,0.01,0.03,0.1,0.3,1,3,10,30,100];

numItersMax = 300;
stepIters = 10;
% Carga estática de datos %

load dmoz-web-directory-topics.mat;
X = full(data)';
y = label';
y = y.-4;
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
%num_ocultas = 150;
num_etiquetas = 5;
lambda = 0;
m = size(X)(1);

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);
X_train_unos = [ones(mtrain, 1), Xtrain];

Xval = X(mtrain+1:end,:);
yval = y(mtrain+1:end);
X_val_unos =  [ones(size(Xval)(1), 1), Xval];

contTam = 1;
for num_ocultas = num_ocultas_vals;
	ThetaIni1 = pesosAleatorios(num_entradas,num_ocultas);
	ThetaIni2 = pesosAleatorios(num_ocultas,num_etiquetas);
	thetaIni = [ThetaIni1(:); ThetaIni2(:)];

	contLambda = 1;
	for lambda = lambdaVals
		contIters=1;
		printf("Iteración contTam: %d, num_ocultas: %d\n", contTam,num_ocultas);	
		printf("Iteración contLambda: %d, lambda: %.3f\n", contLambda,lambda);	
	thetaProc = thetaIni;
		for iter = stepIters:stepIters:numItersMax
		#	printf("Iteración contIters: %d, iteraciones: %d\n", contIters,iter);	
			#tic()
			opciones = optimset ('Gradobj', 'on', 'MaxIter', stepIters);

			dataSave(contTam, contLambda, contIters).iter = iter;
			dataSave(contTam, contLambda, contIters).lambda = lambda;
			dataSave(contTam, contLambda, contIters).num_ocultas = num_ocultas;

			funCosteTrain = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain, lambda));
			funCosteVal = @(p)(costeRN(p, num_entradas, num_ocultas, num_etiquetas, X_val_unos, yval, lambda));
			errTrain = @(p)(err(p, num_entradas, num_ocultas, num_etiquetas, X_train_unos, ytrain));
			errVal = @(p)(err(p, num_entradas, num_ocultas, num_etiquetas, X_val_unos, yval));

			% Entrena %
			[thetaProc, cost] = fmincg (funCosteTrain, thetaProc, opciones);
	
			% Guarda datos %
#			[dataSave(contIters).costeEntren void] = funCosteTrain(thetaProc);
#			[dataSave(contIters).costeVal void] = funCosteVal(thetaProc);

			dataSave(contTam, contLambda, contIters).errTrain = errTrain(thetaProc);
			dataSave(contTam, contLambda, contIters).errVal = errVal(thetaProc);

#			ThetaProc1 = reshape(thetaProc(1:num_ocultas * (num_entradas + 1)), ... 
#				num_ocultas, (num_entradas + 1));
#			ThetaProc2 = reshape(thetaProc((1 + (num_ocultas * (num_entradas + 1))):end), ...
#				num_etiquetas, (num_ocultas + 1));

#			[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_train_unos);
#			dataSave(contIters).porcentajeEntren = porcentajeAciertos(ytrain, yPred);
#			dataSave(contIters).porcentajeEntren;
#			[a1, a2, z2, yPred] = red(ThetaProc1, ThetaProc2, X_val_unos);
#			dataSave(contIters).porcentajeTest = porcentajeAciertos(yval, yPred);
#			dataSave(contIters).porcentajeTest;
	
			contIters++;	
			#toc()
		endfor % iters %
		contLambda++;
	endfor % Lambda %
	contTam++;
endfor % Tam %
save dataSavePruebaTotal100 dataSave;
