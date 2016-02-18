addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;

usingFminunc = false;

lambda = 50;
iteraciones = 50;

num_etiquetas = 5;
i = 1;
# Palabras que aparezcan menos de min veces se eliminaran


for min=0:10:1000

	#min = 100; # Palabras que aparezcan menos de min veces se eliminaran
	% Carga estática de datos  con tfidf %
	load dmoz-web-directory-topics.mat;
	[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
	clear data label mldata_descr_ordering;

	num_entradas = size(X)(2);
	m = size(X)(1);
	n = size(X)(2);

	Xtrain = X(1:mtrain,:);
	ytrain = y(1:mtrain);
	#X_train_unos = [ones(mtrain, 1), Xtrain];

	Xval = X(mtrain+1:end,:);
	yval = y(mtrain+1:end);
	#X_val_unos =  [ones(size(Xval)(1), 1), Xval];

	Thetas = oneVsAll(Xtrain, ytrain, num_etiquetas, lambda, iteraciones, usingFminunc);
	printf("Con %d ejemplos de entrenamiento, %d ejemplos de validacion, %d palabras\n\t%% aciertos sobre validacion: %.4f\n", mtrain, length(y), n, porcentajeAciertosLog(Thetas , Xval , yval ));

	dataSave(i).palabras = n;
	dataSave(i).min = min;
	dataSave(i).porcentajeVal = porcentajeAciertosLog(Thetas, Xval, yval);
	dataSave(i).porcentajeEnt = porcentajeAciertosLog(Thetas, Xtrain, ytrain);
	i++;

endfor

save dataSavePalabrasLog dataSave;
