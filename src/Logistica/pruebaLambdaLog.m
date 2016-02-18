addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;

usingFminunc = false;

# Palabras que aparezcan menos de min veces se eliminaran
iteraciones = 50;
min = 200; # Palabras que aparezcan menos de min veces se eliminaran
num_etiquetas = 5;

lambdaVals = [0.0001 0.0003 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10 30 100];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TF IDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carga estática de datos  con tfidf %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);

Xval = X(mtrain+1:end,:);
yval = y(mtrain+1:end);

i = 1;
for lambda=lambdaVals
	
	Thetas = oneVsAll(Xtrain, ytrain, num_etiquetas, lambda, iteraciones, usingFminunc);
	printf("TF idf Con %d ejemplos de entrenamiento, %d ejemplos de validacion, %d palabras %.4f lambda \n\t%% aciertos sobre validacion: %.4f\n", mtrain, length(y), n, lambda, porcentajeAciertosLog(Thetas , Xval , yval ));

	dataSave.tfidf(i).lambda = lambda;
	dataSave.tfidf(i).porcentajeVal = porcentajeAciertosLog(Thetas, Xval, yval);
	dataSave.tfidf(i).porcentajeEnt = porcentajeAciertosLog(Thetas, Xtrain, ytrain);
	i++;

endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NORMAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carga estática de datos  con tfidf %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatos(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);

Xval = X(mtrain+1:end,:);
yval = y(mtrain+1:end);

i = 1;
for lambda=lambdaVals
	
	Thetas = oneVsAll(Xtrain, ytrain, num_etiquetas, lambda, iteraciones, usingFminunc);
	printf("Normal Con %d ejemplos de entrenamiento, %d ejemplos de validacion, %d palabras %.4f lambda \n\t%% aciertos sobre validacion: %.4f\n", mtrain, length(y), n, lambda, porcentajeAciertosLog(Thetas , Xval , yval ));

	dataSave.normal(i).lambda = lambda;
	dataSave.normal(i).porcentajeVal = porcentajeAciertosLog(Thetas, Xval, yval);
	dataSave.normal(i).porcentajeEnt = porcentajeAciertosLog(Thetas, Xtrain, ytrain);
	i++;

endfor

save dataSaveLambdaLog dataSave;
