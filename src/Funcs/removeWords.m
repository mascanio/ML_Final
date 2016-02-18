function X = removeWords(X, y, min, num_etiquetas)

m = size(X)(1);
n = size(X)(2);
topicDic = zeros(num_etiquetas, n);
for i=1:m
	topicDic(y(i), :) = topicDic(y(i), :) + X(i,:);
endfor
cont = 0;

validIdx = find(sum(topicDic) > min);
X = X(:,validIdx);

endfunction
