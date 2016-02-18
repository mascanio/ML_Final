function tf = tfLog(term, document)
	a = document(:,term)(:);
	idx = find(a > 0);

	tf = zeros(size(a));
	tf(idx) = 1 + log(a(idx)); 

	tf = reshape(tf, size(document(:,term)));

endfunction
