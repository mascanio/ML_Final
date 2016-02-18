addpath Funcs/;
clear;
addpath /usr/lib/libsvm-3.20/matlab;
% Párametros del test %
mtrain = 850;

cVals = [0.0001 0.0003 0.001 0.003 0.01 0.03 0.1 0.3];
num_etiquetas = 5;

min = 10; # Palabras que aparezcan menos de min veces se eliminaran

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

X_train = X(1:mtrain,:);
y_train = y(1:mtrain);

X_val = X(mtrain+1:end,:);
y_val = y(mtrain+1:end);
tic();

i = 1;
for c = cVals
	opts = sprintf("-t 0 -q -c %f", c);
	model = svmtrain(double(y_train), double(X_train), opts);
	[void, trainPorA, void] = svmpredict(double(y_train), double(X_train), model, '-q');
	[void, valPorA, void] = svmpredict(double(y_val), double(X_val), model, '');
fflush(1)
	trainPor(i) = trainPorA(1);
	valPor(i) = valPorA(1);
	i++;
endfor
toc()


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NORMAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carga estática de datos %
load dmoz-web-directory-topics.mat;
[X y] = cargaDatos(data, label, num_etiquetas, min);
clear data label mldata_descr_ordering;

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

X_train = X(1:mtrain,:);
y_train = y(1:mtrain);

X_val = X(mtrain+1:end,:);
y_val = y(mtrain+1:end);
tic();

i = 1;
for c = cVals
	opts = sprintf("-t 0 -q -c %f", c);
	model = svmtrain(double(y_train), double(X_train), opts);
	[void, trainPorA, void] = svmpredict(double(y_train), double(X_train), model, '-q');
	[void, valPorA, void] = svmpredict(double(y_val), double(X_val), model, '');
fflush(1)
	trainPorn(i) = trainPorA(1);
	valPorn(i) = valPorA(1);
	i++;
endfor
toc()

plot(cVals, trainPor, 'color', 'b');
hold on;
plot(cVals, valPor, 'color', 'g');

plot(cVals, trainPorn, 'color', 'red');
plot(cVals, valPorn, 'color', 'black');
