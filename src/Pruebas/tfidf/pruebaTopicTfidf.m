addpath Funcs/;
clear;

load dmoz-web-directory-topics.mat;
X = full(data)';

y = label';
y = y.-4;

m = size(X)(1);
n = size(X)(2);
num_etiquetas = 5;

topicDic = zeros(num_etiquetas, n);

for i=1:m
	topicDic(y(i), :) = topicDic(y(i), :) + X(i,:);
endfor
cont = 0;

validIdx = find(sum(topicDic) > 0); % Eliminar las palabras que no aparecen nunca
printf("Se eliminan %d palabras que no aparecen nunca\n", n-length(validIdx));
topicDic = topicDic(:, validIdx);

a = tfidf(1:size(topicDic)(2), topicDic, topicDic );

validIdx = find(sum(a) > 0); % Eliminar las palabras que su tfidf es 0
printf("Se eliminan %d palabras que su idf es 0\n", n-length(validIdx));

topicDic = topicDic(:, validIdx);
printf("Esto hace un total de %d palabras\n", length(topicDic));




