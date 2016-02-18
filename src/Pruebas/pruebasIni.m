addpath Funcs/;
clear;
load dmoz-web-directory-topics.mat;
X = full(data)';
y = label';
y = y.-4;
clear data label mldata_descr_ordering;

m = size(X)(1); # Number of training examples
n = size(X)(2); # Number of features

numOfTopWords = 100;

for v = 1:m
	posNonZero(v).pos = (find(X(v,:) != 0));
endfor

tams = [];
for v = 1:m
	actual(v).valores = X(v, posNonZero(v).pos);
	actual(v).num = length(actual(v).valores);
	
	tams = [tams actual(v).num];
endfor

for v = 1:m
	actual(v).valores = sort(actual(v).valores);
endfor

acuMax = [];

numOuts = 0;
for v = 1:m
	if(actual(v).num > numOfTopWords)
		acuMax = [acuMax max(actual(v).valores(1:actual(v).num-numOfTopWords))];
	else
		numOuts++;		
	endif
endfor

sort(acuMax)';

numOuts;

num = 0;
for v= 1:n
	vals = [0,0,0,0,0];
	v = (y(find(X(:,v) != 0)));
	for i = 1:length(v)
		vals(v(i)) = vals(v(i)) + 1;
	endfor
	if(length(v) > 10)
		vals .* (1/length(v));
		if (std(vals) > 0.2)
			num++;
			vals
		endif
	endif
endfor

num
