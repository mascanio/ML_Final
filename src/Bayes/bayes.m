addpath Funcs/;
clear;
% Párametros del test %
mtrain = 850;
use_tfidf = false;

min = 0; # Palabras que aparezcan menos de min veces se eliminaran
% Carga estática de datos %
num_etiquetas = 5;
load dmoz-web-directory-topics.mat;
if(use_tfidf)
[X y] = cargaDatostfidf(data, label, num_etiquetas, min);
else
[X y] = cargaDatos(data, label, num_etiquetas, min);
endif
clear data label mldata_descr_ordering;

X = double(X);
y = double(y);

num_entradas = size(X)(2);
m = size(X)(1);
n = size(X)(2);

Xtrain = double(X(1:mtrain,:));
ytrain = double(y(1:mtrain));

Xval = double(X(mtrain+1:end,:));
yval = double(y(mtrain+1:end));

% Indices para cada uno de los topics

ytrainTrans = transformaEtiquetas(ytrain, num_etiquetas);
for i=1:num_etiquetas
	idx(i).a = find(ytrainTrans(:,i));
endfor

% Calcular la probabilidad de cada topic

for i=1:num_etiquetas
	prob_topic(i) = length(find(ytrainTrans(:,i))) / length(ytrainTrans);
endfor

% Calculamos la longitud de cada web

webs_lengths = sum(Xtrain, 2);

% Longitud de cada web para cada topic

for i=1:num_etiquetas
	t_wc(i).a = sum(webs_lengths (idx(i).a));
endfor

% Calcular la probabilidad de cada palabra para cada topic
	
for i=1:num_etiquetas
	prob_tokens(i).a = (sum(Xtrain(idx(i).a, :)) + 1) ./ (t_wc(i).a + m);
endfor

% prob_tokens(i).a(k) = P(k|y=i), esto es, la probabilidad de que la palabra k-esima sea del topic i

for i = 1:num_etiquetas
	bayesProb(:,i) = Xval * ((log(prob_tokens(i).a))' + log(prob_topic(i)));
endfor

porcentajeAciertosBayes(bayesProb, Xval, yval )

% prob_tokens(i).a(k) = P(k|y=i), esto es, la probabilidad de que la palabra k-esima sea del topic i
Xval = Xval > 0;
for i = 1:num_etiquetas
	for j = 1:size(Xval)(1)
		idxval = find(Xval(j,:));
		p(i,j) = prod(prob_tokens(i).a(idxval)) * prob_topic(i);
	endfor
endfor




porcentajeAciertosBayes(p', Xval, yval )

