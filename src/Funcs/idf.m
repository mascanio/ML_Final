function idf = idf(term, Collection)
	N = rows(Collection);

	for i=1:size(Collection)(2)
		df(i) = (length(find(Collection(:,i)!= 0)));
	endfor

	idf = log(N ./ df);

endfunction
#function idf = idf(term, Collection)
#	N = rows(Collection);

#	for i=1:size(Collection)(2)
#		df(i) = (length(find(Collection(:,i)!= 0)));
#	endfor

#	idf = log((1/N) * df);

#endfunction
