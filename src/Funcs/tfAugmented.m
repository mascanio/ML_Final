function tf = tfAugmented(term, document, a)
	if(!exist(a))
		a = 0.5;
	endif
	tf = a + (((1-a) * document(term)) / (max(document));
endfunction
