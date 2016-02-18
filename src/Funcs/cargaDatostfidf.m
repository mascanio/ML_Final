function [X, y] = cargaDatostfidf(data, label, num_etiquetas,min)
	X = full(data)';
	y = label';
	y = y .-4;

	X = removeWords(X,y,min,num_etiquetas);
	X = tfidf(1:size(X)(2),X,X);
endfunction
