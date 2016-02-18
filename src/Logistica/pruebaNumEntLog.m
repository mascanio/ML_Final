addpath Funcs/;
clear;
% Párametros del test %

usingFminunc = false;
iteraciones = 50;
# Palabras que aparezcan menos de min veces se eliminaran
min = 300; # Palabras que aparezcan menos de min veces se eliminaran
lambda = 50;
mtrain = 850;

num_etiquetas = 5;

mtrainMax = 1000;
mtrainStep = 50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TF IDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carga estática de datos con tfidf %
i = 1;
for mtrain=mtrainStep:mtrainStep:mtrainMax

load dmoz-web-directory-topics.mat;
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);

Xval = X(mtrainMax+1:end,:);
yval = y(mtrainMax+1:end);
	
	Thetas = oneVsAll(Xtrain, ytrain, num_etiquetas, lambda, iteraciones, usingFminunc);
	printf("TF idf Con %d ejemplos de entrenamiento, %d ejemplos de validacion, %d palabras %.4f lambda \n\t%% aciertos sobre validacion: %.4f\n", mtrain, length(y), n, lambda, porcentajeAciertosLog(Thetas , Xval , yval ));

	dataSave.tfidf(i).mtrain = mtrain;
	dataSave.tfidf(i).porcentajeVal = porcentajeAciertosLog(Thetas, Xval, yval);
	dataSave.tfidf(i).porcentajeEnt = porcentajeAciertosLog(Thetas, Xtrain, ytrain);
	i++;

endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NORMAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i = 1;
for mtrain=mtrainStep:mtrainStep:mtrainMax

% Carga estática de datos %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatos(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

Xtrain = X(1:mtrain,:);
ytrain = y(1:mtrain);

Xval = X(mtrainMax+1:end,:);
yval = y(mtrainMax+1:end);
	
	Thetas = oneVsAll(Xtrain, ytrain, num_etiquetas, lambda, iteraciones, usingFminunc);
	printf("Normal Con %d ejemplos de entrenamiento, %d ejemplos de validacion, %d palabras %.4f lambda \n\t%% aciertos sobre validacion: %.4f\n", mtrain, length(y), n, lambda, porcentajeAciertosLog(Thetas , Xval , yval ));

	dataSave.normal(i).mtrain = mtrain;
	dataSave.normal(i).porcentajeVal = porcentajeAciertosLog(Thetas, Xval, yval);
	dataSave.normal(i).porcentajeEnt = porcentajeAciertosLog(Thetas, Xtrain, ytrain);
	i++;

endfor

save dataSaveNumEntLog dataSave;
